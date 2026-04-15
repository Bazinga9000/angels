let
  keys = {
    metatron = {
      root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICG2XndPy3BEFltSxNoO0sbPbfxhlnayMHlJRaBuytMA root@metatron";
      bazinga = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEs0C3/IHk8lVp/RjcWxxrqwmMFoSs+q1z18Sb7fc4W7 bazinga@metatron";
    };

    jophiel = {
      root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3vqUDsF4+l55ZNNAuDsEPTS/lr0jhD2QkYwdgl+78Y root@jophiel";
      bazinga = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwaXZxgCMvBaEs0Fxr/cM5eauwXiDMjq2QeL0j5qhv1 bazinga@jophiel";
    };

    baraqiel = {
      # The phone isn't rooted, so we're lying about the usernames. but whatever.
      root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE6Vu0B630Sqc9j6WWftKRKZPSN17vlst+QyQaoMgqo7 u0_a339@localhost";
      bazinga = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPekt+iFjr1ZYsrmaMcDkDwgywqb+bFOIULR5VhTeBB u0_a339@localhost";
    };
  };
in
{
  flake.ssh = with builtins; {
    keys = keys;
    allKeys = concatMap attrValues (attrValues keys);
    allHostKeys = attrValues (mapAttrs (_: hostSet: hostSet."root") keys);
    allUserKeys = concatMap attrValues (
      attrValues (mapAttrs (_: hostSet: removeAttrs hostSet [ "root" ]) keys)
    );
  };
}
