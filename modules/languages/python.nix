{ lib, ... }:
{
  flake.aspects.python = {
    description = ''
      Tools for Python
    '';

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          python3
          python310
          python313
          uv
        ];

        environment.sessionVariables = {
          # uv - Don't automatically install python binaries
          UV_PYTHON_DOWNLOADS = "never";
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vscode.profiles.default.extensions = lib.optionals (pkgs ? vscode-marketplace) (
            with pkgs.vscode-marketplace;
            [
              ms-python.python
              ms-python.vscode-pylance
              ms-python.vscode-pylance
              ms-python.debugpy
              batisteo.vscode-django
            ]
          );
        };
      };
  };
}
