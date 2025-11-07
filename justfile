_default:
  @just --list --justfile {{justfile()}}

# Rebuild system
rebuild *FLAGS:
    git add --intent-to-add *
    nix run .#write-flake
    nh os switch --ask --hostname $(hostname) . {{FLAGS}}


# Update the flake inputs, then rebuild the system
update *FLAGS:
    nix run .#write-flake
    nh os switch --update --ask --hostname $(hostname) . {{FLAGS}}
    git add flake.lock
    git commit -m "flake: update"
    git push origin main

# Add necessary external files to the Nix Store (see ./store-files/README.md for details)
store:
    nix-store --add-fixed sha256 ./store-files/Wolfram_14.2.1_LIN_Bndl.sh
    nix-store --add-fixed sha256 ./store-files/baserom.us.z64
    nix-store --add-fixed sha256 ./store-files/ASM_linux.tar.gz


# Garbage Collect the Nix Store (and then re-add required store files)
clean:
    sudo nix-collect-garbage -d
    @just --justfile {{justfile()}} store

# Commit the entire working tree, and push to remote
deploy:
    git add *
    git commit
    git push origin main
