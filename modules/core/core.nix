{
  flake.aspects =
    { aspects, ... }:
    {
      core = {
        description = ''
          The core aspect included in all hosts.
        '';
        # Include the various core aspects in all hosts
        includes = with aspects; [
          agenix
          angels
          boot
          caches
          cli
          hyfetch
          ghostty
          kernel
          locale
          networking
          nix-meta
          nushell
          printing
          sound
          ssh
          tailscale
          vim
          xserver
        ];

        nixos = { };
        homeManager = { };
      };
    };
}
