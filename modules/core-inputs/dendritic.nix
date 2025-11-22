# Enable various modules for the Dendritic Pattern (e.g den, flake-aspects)
{ inputs, lib, ... }:
{
  flake-file.inputs.flake-file.url = lib.mkDefault "github:vic/flake-file";
  flake-file.inputs.den.url = lib.mkDefault "github:vic/den";
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
    inputs.flake-aspects.flakeModule
  ];
}
