{ config, pkgs, options,...}:

{
  nixpkgs.overlays =
    [ 
      (self: super: {
        awesome = super.awesome.overrideAttrs (old: {
          src = super.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            # Commit hash
            rev = "7707618336a9aabf8194d1be93f4a03e4ad01d07";
            sha256 = "sha256:e6f5c7980862b7c3ec6c50c643b15ff2249310cc";
          };
          # Using LuaJIT
          lgi = pkgs.luajitPackages.lgi;
          lua = pkgs.luajitPackages.lua;
          ldoc = pkgs.luajitPackages.ldoc;
        });

      })
    ];
}
