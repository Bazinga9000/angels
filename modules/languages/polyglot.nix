{
  flake.aspects =
    { aspects, ... }:
    {
      polyglot = {
        description = ''
          Aspect that includes all languages.
        '';
        # Include the various core aspects in all hosts
        includes = with aspects; [
          c-cpp
          haskell
          latex
          lua
          mathematica
          nix
          nu
          purescript
          python
          rust
          uiua
        ];

        nixos = { };
        homeManager = { };
      };
    };
}
