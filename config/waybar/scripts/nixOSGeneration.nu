let gen = readlink /nix/var/nix/profiles/system | cut -d- -f2
let latest_nixpkgs = gh api --method GET /repos/nixos/nixpkgs/commits?sha=nixos-unstable | from json | get commit.committer.date.0 | into datetime
let current_nixpkgs = open ~/metatron/flake.lock | from json | get nodes.nixpkgs.locked.lastModified | $in * 1_000_000_000 | into datetime
let difference = $latest_nixpkgs - $current_nixpkgs
let out = {
    text: $gen
    tooltip: $"Current Nixpkgs Release: ($current_nixpkgs)\rLatest Nixpkgs Release: ($latest_nixpkgs)\r\(($difference) out of date\)"
} | to json -r
echo $out
