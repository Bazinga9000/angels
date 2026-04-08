## Agenix secrets.nix
let
  ssh = (import ./modules/core/ssh/keys.nix).flake.ssh;

  allKeyArmoredSecret = {
    publicKeys = ssh.allKeys;
    armor = true;
  };
in
{
  "tailscale_auth.age" = allKeyArmoredSecret;
}
