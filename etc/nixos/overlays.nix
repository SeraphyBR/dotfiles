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

        cava = super.cava.overrideAttrs(old: {
          src = builtins.fetchGit {
            url = "https://github.com/karlstav/cava.git";
            ref = "master";
            rev = "c57538d072967e0906c81642f74c5161d78c24b2";
          };
        });

      })
    ];
}
