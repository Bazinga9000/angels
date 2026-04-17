{
  flake.aspects.helix = {
    description = ''
      Enable the Helix text editor.
    '';

    homeManager = {
      programs.helix.enable = true;
    };
  };
}
