
{ config, pkgs, ... }:

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
  hardware.pulseaudio.support32Bit = true;
  hardware.steam-hardware.enable = true;

  environment.pathsToLink = [ "/libexec" ];

  environment.systemPackages = with pkgs; [
    #terminal & tools
    kitty neofetch cava calc htop ranger
    wget unzip exa pciutils unrar psmisc
    calc cmatrix iw

    #theme
    lxappearance papirus-icon-theme
    hsetroot nitrogen gcolor2 libsForQt5.qtstyleplugins
    betterlockscreen

    #browser
    qutebrowser

    #chat
    tdesktop discord teams 

    #audio & video
    ncmpcpp mpd playerctl mpc_cli mpv
    youtube-dl pavucontrol ffmpeg ffmpegthumbnailer
    ueberzug

    #image
    sxiv ueberzug shotgun nur.repos.nexromancers.pkgs.hacksaw
    neovim vscode
    #editor/ide
    vscode

    #printer
    simple-scan hplip

    #dev
    git gitAndTools.gh insomnia 
    gcc zlib cmake musl clang clang-tools bzip2 
    gnumake lua binutils.bintools gdb
    pkg-config python38Full dotnet-sdk

    #rust dev
    rustup cargo-edit lldb

    #node dev
    nodejs yarn

    #tools
    gparted gnome3.gucharmap

    #xorg
    xorg.xdpyinfo wmctrl libnotify xorg.xkill
    xclip arandr xautolock picom dragon-drop
    nvidia-offload glxinfo 

    #others
    udiskie rofi 
    zathura virt-manager polkit_gnome 
    geoclue2 transmission-gtk

  ];

  environment.sessionVariables.TERMINAL = [ "kitty" ];
  environment.sessionVariables.EDITOR = [ "nvim" ];
}
