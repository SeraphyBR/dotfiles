{ config, pkgs, options, lib, ... }:

{
  # Addicional configs
  specialisation = {
    gamer-nvidia.configuration = {
      imports = [ ./nvidia.nix ];
    };

   # gnome.configuration = {
   #   services.xserver = {
   #     displayManager.startx.enable = lib.mkForce false;
   #     displayManager.gdm.enable = true;
   #     desktopManager.gnome.enable = true;
   #   };
   #
   #   home-manager.users.seraphybr = {
   #     xsession.enable = lib.mkForce false;
   #     xsession.windowManager.awesome.enable = lib.mkForce false;
   #   };
   #
   #   environment.systemPackages = with pkgs; [
   #     gnome.gnome-tweak-tool
   #   ];
   # };
  };
}
