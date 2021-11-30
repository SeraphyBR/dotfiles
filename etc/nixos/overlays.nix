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
            rev = "2eb035e1257c05aaaea33540e3db8dea504c2d13";
            sha256 = "sha256:10k1bkif7mqqhgwbvh0vi13gf1qgxszack3r0shmsdainm37hqz3";
          };
          # Using LuaJIT
          lgi = pkgs.luajitPackages.lgi;
          lua = pkgs.luajitPackages.lua;
          ldoc = pkgs.luajitPackages.ldoc;
        });

      })
    ];
}
