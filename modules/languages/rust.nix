{
  flake.aspects.rust = {
    description = ''
      Tools for Rust
    '';

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        rustup
      ];
    };

    homeManager.programs.zed-editor.extensions = ["rust-snippets"];
  };
}
