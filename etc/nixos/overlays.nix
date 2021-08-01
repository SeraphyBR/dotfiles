{ config, pkgs, options,...}:

{
  nixpkgs.overlays =
    [ 
      (self: super: {
        #vimix-gtk-themes = super.vimix-gtk-themes.overrideAttrs(old: {
        #  installPhase = ''
        #  patchShebangs .
        #  mkdir -p $out/share/themes
        #  name= ./install.sh -a -d $out/share/themes
        #  rm $out/share/themes/*/{AUTHORS,LICENSE}
        #  '';
        #});

        awesome = super.awesome.overrideAttrs (old: {
          src = super.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            # Commit hash
            rev = "e0e8f3fd728012e19231771651e0ee5f3212fea3";
            sha256 = "sha256:0z76bwfqx6fq3j6aq81fbyrvrrjixxxapxkn8fqdrdfg2b0ni56w";
          };
          # Using LuaJIT
          lgi = pkgs.luajitPackages.lgi;
          lua = pkgs.luajitPackages.lua;
          ldoc = pkgs.luajitPackages.ldoc;
        });

        betterlockscreen = super.betterlockscreen.overrideAttrs (old: {
           version = "v4.0.0-beta1";
        });

      })
    ];
}
