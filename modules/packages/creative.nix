{
  flake.aspects =
    { aspects, ... }:
    {
      creative = {
        description = ''
          Programs for art, music and general creation.
        '';

        includes = with aspects; [ baz9k ];

        homeManager =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              gimp2 # Gnu Image Manipulation Program (v2 becuase v3 crashes)
              graphviz # Graph visualization tools
              helio-workstation # Musical composition software
              inkscape # Vector graphics program
              microwave # Microtonal synthesizer
              krita # Art program
              obs-studio # Open Broadcast Studio for recording
              qgis # Geographic Information System
              yed # Graph Editor
            ];
          };
      };
    };
}
