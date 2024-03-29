{ pkgs, config,... }:
let
  dotfiles = "/home/seraphybr/Git/dotfiles";
in
{
  imports = [
    (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz}/nixos")
  ];

  fonts.packages = with pkgs; [
    fira-code
    cantarell-fonts
    open-sans # Fix telegram font issue
    noto-fonts
    noto-fonts-cjk
    font-awesome_4
    material-design-icons
    corefonts
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.seraphybr = {
    home.stateVersion = "23.11";
    home.packages = with pkgs; [
      #terminal & tools
      kitty cava calc hsetroot
      gitAndTools.gh

      #browser
      qutebrowser microsoft-edge

      #mail
      thunderbird

      #chat
      tdesktop discord

      #audio & video
      ncmpcpp mpd playerctl mpc_cli mpv
      youtube-dl pavucontrol ffmpeg ffmpegthumbnailer
      ueberzug

      #image
      sxiv shotgun hacksaw

      #editor/ide
      neovim

      #printer
      simple-scan

      #others
      udiskie rofi zathura virt-manager
      geoclue2 transmission-gtk insomnia
      gcolor2 gnome3.gucharmap bitwarden

      #xorg
      xorg.xdpyinfo wmctrl libnotify xorg.xkill
      xclip arandr xautolock xdragon
      glxinfo xorg.xev snixembed

    ];

    programs = {
      home-manager.enable = true;
      vscode = {
        enable = true;
        package = pkgs.vscode-fhs;
      };
      git = {
        enable = true;
        userName  = "SeraphyBR";
        userEmail = "luisjuniorbr@gmail.com";
      };
    };

    services = {
      picom = {
        enable = true;
        opacityRules = [ "92:class_g = 'Code'" ];
        backend = "glx";
        vSync = false;
        shadowExclude = [ "name = 'hacksaw'" ];
      };
    };

    xdg = {
      enable = true;
      userDirs.enable = true;
    };

    # NixOS already handle this
    home.keyboard = null;

    home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        x11.enable = true;
    };

    xsession = {
      # Needed for things like qt.platformTheme
      enable = true;
      scriptPath = ".xsession-hm";
      # NixOS already handle this
      windowManager.command = "";
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

      gtk3.extraConfig = {
        # No Close,Minimize,Maximize Buttons inside gtk apps
        gtk-decoration-layout = "appmenu:";
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


      # Some weird bug
      manual.manpages.enable = false;
      manual.html.enable = false;
      manual.json.enable = false;

  };

  home-manager.users.root = {
    home.stateVersion = "23.11";
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

      # Some weird bug
      manual.manpages.enable = false;
      manual.html.enable = false;
      manual.json.enable = false;
  };

}
