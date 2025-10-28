{
  flake.aspects.vim = {
    description = ''
      Enable the vim text editor.
    '';

    nixos = {
      programs.vim.enable = true;
    };
  };
}
