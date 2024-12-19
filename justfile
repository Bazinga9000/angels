_default:
  @just --list --justfile {{justfile()}}

# Rebuild system
rebuild *FLAGS:
    git add --intent-to-add *
    sudo nixos-rebuild switch --flake .#metatron {{FLAGS}}

# Update the flake inputs, then rebuild the system
update *FLAGS:
    nix flake update
    @just --justfile {{justfile()}} rebuild {{FLAGS}}
    git add flake.lock
    git commit -m "update flake"
    git push origin main

# Refresh hyprlock
relock:
    killall -9 hyprlock
    hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
    hyprctl --instance 0 'dispatch exec hyprlock'

# Add necessary external files to the Nix Store (see ./store-files/README.md for details)
store:
    nix-store --add-fixed sha256 ./store-files/Wolfram_14.1.0_LIN_Bndl.sh
    nix-store --add-fixed sha256 ./store-files/baserom.us.z64


# Garbage Collect the Nix Store (and then re-add required store files)
clean:
    sudo nix-collect-garbage -d
    @just --justfile {{justfile()}} store

# Commit the entire working tree, and push to remote
deploy:
    git add *
    git commit
    git push origin main
