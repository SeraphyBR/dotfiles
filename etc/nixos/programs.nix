
{ config, pkgs, options,... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Virtualization section
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # Security section
  security.apparmor.enable = true;
  security.polkit.enable = true;
  security.sudo.enable = false;
  security.pam.services.seraphybr.enableGnomeKeyring = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
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

  environment.sessionVariables.TERMINAL = [ "kitty" ];
  environment.sessionVariables.EDITOR = [ "nvim" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #
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
    omnisharp-roslyn mono msbuild
    (with dotnetCorePackages; combinePackages [
      sdk_5_0
      sdk_3_1
      sdk_3_0
    ])

    #rust dev
    rustup lldb rust-analyzer

    #node dev
    nodejs yarn

    #tools
    gparted jmtpfs

    #others
    polkit_gnome

  ];
}
