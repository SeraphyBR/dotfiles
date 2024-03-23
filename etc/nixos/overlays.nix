{ config, pkgs, options,...}:

{
  nixpkgs.overlays =
    [ 
      (final: prev: {
        awesome = prev.awesome.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            # Commit hash
            rev = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
            hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
          };
          patches = [ ];

          postPatch = ''
            patchShebangs tests/examples/_postprocess.lua
          '';
        });

      })
    ];
}
