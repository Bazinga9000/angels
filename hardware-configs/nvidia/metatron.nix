# ABANDON ALL HOPE YE WHO ENTER HERE

{ /* config, */ pkgs, ... }:
let
    drivers = {
      beta = pkgs.linuxPackages.nvidiaPackages.beta;
      latest = pkgs.linuxPackages.nvidiaPackages.latest;
    };
in
{
  # Enable graphics driver
  hardware.graphics.enable = true;

  # NVIDIA Driver
  hardware.nvidia.package = drivers.beta;

  # Hardware Video Acceleration
  hardware.graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
      libva-vdpau-driver
  ];

  # Load "nvidia" driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Magic incantation to fix NVK error
  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";

  # Enable NVIDIA related kernel module
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  # Some environment variables
  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # preferred by NVIDIA for drivers starting at 560
    open = true;

    # Enable the Nvidia settings menu,
    nvidiaSettings = true;

    prime = {
        sync.enable = true;

    	intelBusId = "PCI:0:2:0"; #same on the real machine
    	nvidiaBusId = "PCI:1:0:0";
    };

  };
}
