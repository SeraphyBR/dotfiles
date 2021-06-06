{ config, pkgs, options, ...}:

{
  nixpkgs.overlays =
    [ 
      (self: super: {
        omnisharp-roslyn = super.omnisharp-roslyn.overrideAttrs (old: {
            src = pkgs.fetchurl {
                url = "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.37.6/omnisharp-mono.tar.gz";
                sha256 = "1rjv2602cr4d8q19qx9q2f7i6fi0ir96j9xhmfnqzbimdd9w1rm5";
            };
        });

        vimix-gtk-themes = super.vimix-gtk-themes.overrideAttrs(old: {
          installPhase = ''
          patchShebangs .
          mkdir -p $out/share/themes
          name= ./install.sh -a -d $out/share/themes
          rm $out/share/themes/*/{AUTHORS,LICENSE}
          '';
        });

      })
    ];
}
