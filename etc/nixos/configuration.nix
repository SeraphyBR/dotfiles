# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options,... }:

{
  imports =
    [
      ./users.nix
      ./hardware.nix
      ./network.nix
      ./boot.nix
      ./overlays.nix
      ./programs.nix
      ./services.nix
      ./home.nix
      ./specialisation.nix
    ];

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
      #font = "Lat2-Terminus16";
      #keyMap = "br-abnt2";
      useXkbConfig = true;
    };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}


