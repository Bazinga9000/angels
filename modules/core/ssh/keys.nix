{
  # All SSH public keys.
  # make-host will automatically add every public key listed here as authorized for every user
  # to access these in other modules, use config.flake.ssh-keys
  flake.ssh-keys = {
    metatron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEs0C3/IHk8lVp/RjcWxxrqwmMFoSs+q1z18Sb7fc4W7 bazinga@metatron";
    jophiel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwaXZxgCMvBaEs0Fxr/cM5eauwXiDMjq2QeL0j5qhv1 bazinga@jophiel";
  };
}
