{inputs, ...}: {
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.zen-browser = {
    description = ''
      Zen web browser
    '';

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser.enable = true;
    };
  };
}
