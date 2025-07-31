let gen = readlink /nix/var/nix/profiles/system | cut -d- -f2
let latest_nixpkgs = gh api --method GET /repos/nixos/nixpkgs/commits?sha=nixos-unstable | from json | get commit.committer.date.0 | into datetime
let lock_json = open ~/metatron/flake.lock | from json
let system_nixpkgs_name = $lock_json.nodes.root.inputs.nixpkgs
let current_nixpkgs = ($lock_json.nodes | get $system_nixpkgs_name).locked.lastModified | $in * 1_000_000_000 | into datetime
let difference = $latest_nixpkgs - $current_nixpkgs | into duration

print $"Current Generation: ($gen)"
print $"Current Nixpkgs Release: ($current_nixpkgs)"
print $"Latest Nixpkgs Release: ($latest_nixpkgs)"

if $difference > 0sec {
  print $"Your nixpkgs is ($difference) out of date! Update now? [Y/N]"
  if (input --numchar 2 | str downcase) == "y" {
    just --justfile=/home/bazinga/metatron/justfile store
    just --justfile=/home/bazinga/metatron/justfile update
  }
} else {
  print "Nixpkgs is up to date!"
}
