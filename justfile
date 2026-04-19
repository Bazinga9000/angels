_default:
  @just --list --justfile {{justfile()}}

# Rebuild system
rebuild *FLAGS:
    git add --intent-to-add *
    nix run .#write-flake
    nh os switch --diff always --ask --hostname $(hostname) . {{FLAGS}}


# Update the flake inputs, then rebuild the system
update *FLAGS:
    nix run .#write-flake
    @just --justfile {{justfile()}} store
    nh os switch --diff always --update --ask --hostname $(hostname) . {{FLAGS}}
    git add flake.lock
    git add flake.nix
    git commit -m "flake: update"
    git push origin main

# Add necessary external files to the Nix Store (see ./store-files/README.md for details)
store:
    nix-store --add-fixed sha256 ./store-files/*


# Garbage Collect the Nix Store (and then re-add required store files)
clean:
    nh clean all -K 7d --optimise
    @just --justfile {{justfile()}} store

# Commit the entire working tree, and push to remote
deploy:
    git add *
    git commit
    git push origin main
