{
  flake.aspects = {aspects, ...}: {
    core = {
      description = ''
        The core aspect included in all hosts.
      '';
      # Include the various core aspects in all hosts
      includes = with aspects; [
        angels
        boot
        locale
        networking
        nix-meta
        nushell
        printing
        sound
        vim
        xserver
      ];

      nixos = {};
      homeManager = {};
    };
  };
}
