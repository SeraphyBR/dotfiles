{ pkgs, ... }:
let
  dotfiles = "/home/seraphybr/Git/dotfiles";
in
{
  imports = [
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.seraphybr = {
    programs = {
      home-manager.enable = true;
      git = {
        enable = true;
        userName  = "SeraphyBR";
        userEmail = "luisjuniorbr@gmail.com";
      };
    };

    xsession.enable = true;
    xsession.windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # package manager for lua
        luadbi-mysql # Database abstration layer
        lgi # Lua bindings to GObject libraries
      ];
    }; 

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
        package = pkgs.vimix-gtk-themes;
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
      sxiv shotgun hacksaw

      #editor/ide
      vscode neovim

      #printer
      simple-scan

      #others
      udiskie rofi zathura virt-manager
      geoclue2 transmission-gtk insomnia
      gcolor2 gnome3.gucharmap bitwarden

      #xorg
      xorg.xdpyinfo wmctrl libnotify xorg.xkill
      xclip arandr xautolock picom dragon-drop
      glxinfo xorg.xev

    ];

    xdg.configFile."awesome".source = "${dotfiles}/.config/awesome";
    xdg.configFile."cava/config".source = "${dotfiles}/.config/cava/config";
    xdg.configFile."rofi".source = "${dotfiles}/.config/rofi";
    xdg.configFile."kitty".source = "${dotfiles}/.config/kitty";
    xdg.configFile."mpd/mpd.conf".source = "${dotfiles}/.config/mpd/mpd.conf";

    xdg.configFile."ncmpcpp" = {
      source = "${dotfiles}/.config/ncmpcpp";
      recursive = true;
    };

    xdg.configFile."ranger" = {
      source = "${dotfiles}/.config/ranger";
      recursive = true;
    };

    xdg.configFile."nvim" = {
      source = "${dotfiles}/.config/nvim";
      recursive = true;
    };

    xdg.configFile."zathura".source = "${dotfiles}/.config/zathura";

    xresources.properties = {
      "Xft.dpi" = "96";
      "Sxiv.font" = "Fira Code:size=12";
      "Sxiv.foreground" = "#222222";
      "Sxiv.background" = "#A0C28A";
    };

    home.file.".zshrc".source = "${dotfiles}/.zshrc";
    home.file.".p10k.zsh".source = "${dotfiles}/.p10k.zsh";
    home.file.".xinitrc".source = "${dotfiles}/.xinitrc";

    home.file.".zshenv".text = ''
      # Time zsh command
      export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'
      export PATH="$PATH:$(yarn global bin)"
    '';

    home.file.".ideavimrc".text = ''
      source ~/.config/nvim/init.vim
      set clipboard+=ideaput%
    '';

    home.file.".zlogin".text = ''
      # Auto startx for tty1
      if [ -z "$DISPLAY" ] && [ "$TTY" = "/dev/tty1" ]
      then
          exec startx -- -keeptty -logfile "$HOME/.xorg.log"
      fi
    '';

  };

  home-manager.users.root = {
    xdg.enable = true;

    xdg.configFile."ranger" = {
      source = "${dotfiles}/.config/ranger";
      recursive = true;
    };

    xdg.configFile."nvim" = {
      source = "${dotfiles}/.config/nvim";
      recursive = true;
    };

    home.file.".zshrc".source = "${dotfiles}/.zshrc";
    home.file.".p10k.zsh".source = "${dotfiles}/.p10k.zsh";
  };

}
