cd ~/angels
let latest_nixpkgs = gh api --method GET /repos/nixos/nixpkgs/commits?sha=nixos-unstable | from json | get commit.committer.date.0 | into datetime
let lock_json = open flake.lock | from json
let system_nixpkgs_name = $lock_json.nodes.root.inputs.nixpkgs
let current_nixpkgs = ($lock_json.nodes | get $system_nixpkgs_name).locked.lastModified | $in * 1_000_000_000 | into datetime
let difference = $latest_nixpkgs - $current_nixpkgs | into duration

let current_formatted = $current_nixpkgs | format date "%b %d %Y"
let latest_formatted = $latest_nixpkgs | format date "%b %d %Y"
let out = if $difference == 0sec {
    $"Up to date \(($current_formatted))"
} else {
    $"($difference) out of date \(($current_formatted) -> ($latest_formatted))"
}
echo $out
