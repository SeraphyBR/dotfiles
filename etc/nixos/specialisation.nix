{ config, pkgs, options, lib, ... }:

{
  # Addicional configs
  specialisation = {
    gamer-nvidia.configuration = {
      imports = [ ./nvidia.nix ];
    };

    sway.configuration = {
      imports = [ ./nvidia.nix ];

     services.xserver = {
       displayManager.lightdm.enable = lib.mkForce false;
       windowManager.awesome.enable = lib.mkForce false;
       displayManager.gdm.enable = true;
     };

      programs.sway = {
      	enable = true;
	wrapperFeatures.gtk = true;
	extraPackages = with pkgs; [
	  swaylock
	  wl-clipboard
          waybar
	];
	extraOptions = [ "--unsupported-gpu" ];
      };
	
    };

    gnome.configuration = {
     imports = [ ./nvidia.nix ];
     services.xserver = {
       displayManager.startx.enable = lib.mkForce false;
       displayManager.lightdm.enable = lib.mkForce false;
       displayManager.gdm.enable = true;
       desktopManager.gnome.enable = true;
       windowManager.awesome.enable = lib.mkForce false;
     };

    services.xserver.displayManager.sessionCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 1 0
        ${pkgs.xorg.xrandr}/bin/xrandr --auto
    '';

     services.picom.enable = lib.mkForce false;
     services.redshift.enable = lib.mkForce false;
     services.blueman.enable = lib.mkForce false;

     services.printing = {
	enable = true;
	drivers = [ pkgs.hplip ];
     };

     home-manager.users.seraphybr = {
      gtk.gtk3.extraConfig = lib.mkForce {};
    };

     environment.systemPackages = with pkgs; [
       gnome.gnome-tweaks
     ];
    };

  };
}
