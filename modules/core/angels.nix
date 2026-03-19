{
  flake.aspects.angels = {
    description = ''
      Packages and configurations to interface with this flake
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          # Required to use the flake
          git
          gh
          just
          nh

          # Generally useful cross-host
          wget
          lazygit
        ];

        programs.tmux = {
          enable = true;
          clock24 = true;
        };
      };

    homeManager = {
      programs.btop.enable = true;
    };
  };
}
