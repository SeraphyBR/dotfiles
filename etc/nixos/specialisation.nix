{ config, pkgs, options, lib, ... }:

{
  # Addicional configs
  specialisation = {
    gamer-nvidia.configuration = {
      imports = [ ./nvidia.nix ];
    };

    gnome.configuration = {
     imports = [ ./nvidia.nix ];
     services.xserver = {
       displayManager.startx.enable = lib.mkForce false;
       displayManager.lightdm.enable = lib.mkForce false;
       displayManager.gdm.enable = true;
       desktopManager.gnome.enable = true;
     };

    services.xserver.displayManager.sessionCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 1 0
        ${pkgs.xorg.xrandr}/bin/xrandr --auto
    '';

     services.picom.enable = lib.mkForce false;
     services.redshift.enable = lib.mkForce false;

     home-manager.users.seraphybr = {
      gtk.gtk3.extraConfig = lib.mkForce {};
    };

     environment.systemPackages = with pkgs; [
       gnome.gnome-tweak-tool
     ];
    };

  };
}
