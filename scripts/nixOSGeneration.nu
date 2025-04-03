let gen = readlink /nix/var/nix/profiles/system | cut -d- -f2
let latest_nixpkgs = gh api --method GET /repos/nixos/nixpkgs/commits?sha=nixos-unstable | from json | get commit.committer.date.0 | into datetime
let lock_json = open ~/metatron/flake.lock | from json
let system_nixpkgs_name = $lock_json.nodes.root.inputs.nixpkgs
let current_nixpkgs = ($lock_json.nodes | get $system_nixpkgs_name).locked.lastModified | $in * 1_000_000_000 | into datetime
let difference = $latest_nixpkgs - $current_nixpkgs | into duration
let update = if $difference > 0sec {"󰚰"} else {""}
let out = {
    text: $"($gen)($update)"
    tooltip: $"Current Nixpkgs Release: ($current_nixpkgs)\rLatest Nixpkgs Release: ($latest_nixpkgs)\r\(($difference) out of date\)"
} | to json -r
echo $out
