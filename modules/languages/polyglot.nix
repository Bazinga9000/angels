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
          # purescript # See https://github.com/thomashoneyman/purescript-overlay/issues/138
          python
          rust
          uiua
          typst
        ];

        nixos = { };
        homeManager = { };
      };
    };
}
