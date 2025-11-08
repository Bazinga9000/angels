{
  flake.aspects.uiua = {
    description = ''
      Tools for Uiua
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        (uiua-unstable.override {
          webcamSupport = true;
          windowSupport = true;
        })
      ];

      fonts.packages = with pkgs; [
        uiua386
      ];
    };

    homeManager.programs.zed-editor.extensions = ["uiua"];
  };
}
