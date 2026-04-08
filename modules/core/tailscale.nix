{
  flake.aspects =
    { aspects, ... }:
    {
      tailscale = {
        includes = with aspects; [ agenix ];

        description = ''
          Configures Tailscale VPN using an encrypted authentication key.
        '';

        nixos =
          { config, ... }:
          {
            age.secrets.tailscale_auth.file = ../../secrets/tailscale_auth.age;

            services.tailscale = {
              enable = true;
              authKeyFile = config.age.secrets.tailscale_auth.path;
            };
          };
      };
    };
}
