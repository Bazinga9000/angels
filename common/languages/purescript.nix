{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    purs
    spago-unstable
    purs-tidy-bin.purs-tidy-0_10_0
    purs-backend-es
  ];
}
