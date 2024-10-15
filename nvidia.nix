# ABANDON ALL HOPE YE WHO ENTER HERE

{ /* config, */ pkgs, ... }:
let 
    # driver555 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "555.58";
    #   sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
    #   sha256_aarch64 = "sha256-7XswQwW1iFP4ji5mbRQ6PVEhD4SGWpjUJe1o8zoXYRE=";
    #   openSha256 = "sha256-hEAmFISMuXm8tbsrB+WiUcEFuSGRNZ37aKWvf0WJ2/c=";
    #   settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
    #   persistencedSha256 = "sha256-lyYxDuGDTMdGxX3CaiWUh1IQuQlkI2hPEs5LI20vEVw=";
    # };

    # driver560 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "560.35.03";
    #   sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
    #   sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
    #   openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
    #   settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
    #   persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
    # };

    driverLatest = pkgs.linuxPackages.nvidiaPackages.latest;
    driverPackage = driverLatest;
in
{
  # Enable graphics driver
  hardware.graphics.enable = true;

  # Hardware Video Acceleration
  hardware.graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
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

    package = driverPackage;

    prime = {
        sync.enable = true;

    	intelBusId = "PCI:0:2:0"; #same on the real machine
    	nvidiaBusId = "PCI:1:0:0";
    };
    
  };
}
