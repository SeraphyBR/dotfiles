
{ config, pkgs, options,... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';

in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  programs.command-not-found.enable = true;
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.light.enable = true; # Needed for the /run/wrappers/bin/light SUID wrapper.

  programs.steam.enable = true;
  programs.java.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  environment.pathsToLink = [ "/libexec" ];

  environment.systemPackages = with pkgs; [
    #terminal & tools
    neofetch htop ranger git
    wget unzip exa pciutils unrar psmisc
    cmatrix iw lm_sensors fbcat

    #theme
    betterlockscreen

    #editor/ide
    neovim

    #dev
    gcc zlib cmake musl clang clang-tools bzip2
    gnumake lua binutils.bintools gdb
    pkg-config python38Full 

    # CSharp
    dotnet-sdk_3 dotnet-aspnetcore dotnet-netcore mono6
    omnisharp-roslyn msbuild

    #rust dev
    rustup lldb rust-analyzer

    #node dev
    nodejs yarn

    #tools
    gparted

    #others
    nvidia-offload
    polkit_gnome

  ];

  environment.sessionVariables.TERMINAL = [ "kitty" ];
  environment.sessionVariables.EDITOR = [ "nvim" ];
}
