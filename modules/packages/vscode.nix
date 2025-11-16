{ inputs, ... }:
{
  flake-file.inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects =
    { aspects, ... }:
    {
      vscode = {
        description = ''
          Configuration for VSCode.
        '';

        # Include baz9k aspect for Fairfax HD
        includes = [ aspects.baz9k ];

        nixos =
          { pkgs, ... }:
          {
            nixpkgs.overlays = [
              inputs.nix-vscode-extensions.overlays.default
            ];

            fonts.packages = with pkgs; [
              baz9k.kreative-kore-fonts
              google-fonts
            ];
          };

        homeManager =
          { pkgs, ... }:
          {
            programs.vscode = {
              enable = true;
              # package = pkgs.vscodium;
              profiles.default.enableUpdateCheck = false;
              profiles.default.enableExtensionUpdateCheck = false;
              profiles.default.extensions = with pkgs.vscode-marketplace; [
                formulahendry.auto-close-tag
                formulahendry.code-runner
                naumovs.color-highlight
                icrawl.discord-vscode
                yzhang.markdown-all-in-one
                arrterian.nix-env-selector
                esbenp.prettier-vscode
                jock.svg
                github.vscode-pull-request-github
                redhat.vscode-xml
                redhat.vscode-yaml
              ];

              profiles.default.userSettings = {
                "editor.fontFamily" = "Fairfax HD, monospace";
                "editor.formatOnSave" = true;
                "editor.fontSize" = 18;
                "terminal.integrated.fontSize" = 18;
                "telemetry.telemetryLevel" = "off";
                "github.copilot.enable" = {
                  "*" = false;
                };
              };
            };
          };
      };
    };
}
