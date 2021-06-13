
{ config, pkgs, ... }:

{
  # List services that you want to enable:
  services = {
    # RDP client support
    xrdp.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    # Bluetooth tool
    blueman.enable = true;
    # Gnome Keyring, for stuff like vscode auth github
    gnome.gnome-keyring.enable = true;
    # Postgresql Database (Dev only)
    postgresql = {
      enable = true;
      package = pkgs.postgresql_13;
      authentication = pkgs.lib.mkOverride 13 ''
        local all all trust
        host all all all trust
      '';
    };
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    redshift = {
      enable = true;
      executable = "/bin/redshift-gtk";
      brightness = {
        # Note the string values below.
        day = "1";
        night = "1";
      };
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
    thermald.enable = true;
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "br,us";
      xkbVariant = "abnt2,intl";
      xkbOptions = "grp:shifts_toggle";
      libinput.enable = true;
      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge $HOME/.Xresources
      '';
      updateDbusEnvironment = true;
      serverFlagsSection = ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
      '';
    };

    getty.helpLine = ''

            [0;34;40m ███    ██ ██ ██   ██  ██████  ███████ 
            [0;34;40m ████   ██ ██  ██ ██  ██    ██ ██      
            [0;34;40m ██ ██  ██ ██   ███   ██    ██ ███████ 
            [0;34;40m ██  ██ ██ ██  ██ ██  ██    ██      ██ 
            [0;34;40m ██   ████ ██ ██   ██  ██████  ███████ 
            [0;37;40m
    '';

  };

  location = {
    provider = "manual";
    # Belo Horizonte
    latitude = -19.917299;
    longitude = -43.934559;
  };

  systemd.services.betterlockscreen = {
    enable = true;
    description = "Locks screen when going to sleep/suspend";
    environment = { DISPLAY = ":0"; };
    serviceConfig = {
      User = "seraphybr";
      Type = "simple";
      ExecStart = ''${pkgs.betterlockscreen}/bin/betterlockscreen -l'';
      TimeoutSec = "infinity";
      alias = [ "betterlockscreen@seraphybr.service" ];
    };
    before = [ "sleep.target" "suspend.target" ];
    wantedBy = [ "sleep.target" "suspend.target" ];
  };
}
