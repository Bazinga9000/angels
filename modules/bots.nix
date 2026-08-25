{ inputs, ... }:
{
  flake-file.inputs.weed-lang = {
    url = "github:Bazinga9000/weed-lang";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects =
    { aspects, ... }:
    {
      bots = {
        includes = with aspects; [ agenix ];

        description = ''
          Configures Discord bots that run as NixOS services.
        '';

        nixos =
          { config, ... }:
          {
            age.secrets.shds_bot_token.file = ../secrets/shds_bot_token.age;

            imports = [
              inputs.weed-lang.nixosModules.default
            ];


            services.weed-shds = {
              enable = true;
              tokenPath = config.age.secrets.shds_bot_token.path;
            };
          };
      };
    };
}
