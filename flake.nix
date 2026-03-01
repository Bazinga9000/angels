# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    baz9k-pkgs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Bazinga9000/baz9k-pkgs";
    };
    bizhawk = {
      flake = false;
      url = "github:TASEmulators/BizHawk";
    };
    catppuccin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:catppuccin/nix";
    };
    den.url = "github:vic/den";
    flake-aspects.url = "github:vic/flake-aspects";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hytale-launcher = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:TNAZEP/HytaleLauncherFlake";
    };
    import-tree.url = "github:vic/import-tree";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nix-vscode-extensions = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-vscode-extensions";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-lib.follows = "nixpkgs";
    nixpkgs-patch-hytale = {
      flake = false;
      url = "https://github.com/NixOS/nixpkgs/pull/479368.diff";
    };
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
    purescript-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:thomashoneyman/purescript-overlay";
    };
    uiua = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:uiua-lang/uiua";
    };
    zen-browser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

}
