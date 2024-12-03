default:
  @just --list --justfile {{justfile()}}

# Rebuild system
rebuild *FLAGS:
    git add --intent-to-add *
    sudo nixos-rebuild switch --flake .#metatron {{FLAGS}}
alias r := rebuild

# Update the flake inputs, then rebuild the system
update *FLAGS:
    nix flake update
    @just --justfile {{justfile()}} rebuild {{FLAGS}}
    git add flake.lock
    git commit -m "update flake"
    git push origin main
alias u := update

# Refresh hyprlock
relock:
    killall -9 hyprlock
    hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
    hyprctl --instance 0 'dispatch exec hyprlock'
