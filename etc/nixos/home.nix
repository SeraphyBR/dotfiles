{ pkgs, ... }:

{

  imports = [
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.seraphybr = {
    programs.home-manager.enable = true;

    xdg = {
      enable = true;
      userDirs.enable = true;
    };

    gtk = {
      enable = true;
      font = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell 11";
      };

      theme = {
        name = "vimix-dark-laptop-beryl";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    programs.git = {
      enable = true;
      userName  = "SeraphyBR";
      userEmail = "luisjuniorbr@gmail.com";
    };

    home.sessionVariables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      #terminal & tools
      kitty cava calc hsetroot
      gitAndTools.gh

      #browser
      qutebrowser

      #chat
      tdesktop discord teams

      #audio & video
      ncmpcpp mpd playerctl mpc_cli mpv
      youtube-dl pavucontrol ffmpeg ffmpegthumbnailer
      ueberzug

      #image
      sxiv shotgun 
      nur.repos.nexromancers.pkgs.hacksaw

      #editor/ide
      vscode neovim

      #dev 
      insomnia

      #printer
      simple-scan

      #others
      udiskie rofi zathura virt-manager
      geoclue2 transmission-gtk
      gcolor2 gnome3.gucharmap

      #xorg
      xorg.xdpyinfo wmctrl libnotify xorg.xkill
      xclip arandr xautolock picom dragon-drop
      glxinfo

    ];

  };

}
