# Enable various modules for the Dendritic Pattern (e.g den, flake-aspects)
{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];
}
