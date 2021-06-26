# To build the image: nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

      ./overlays.nix
      ./programs.nix
      ./services.nix
      ./home.nix
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

  users = {
    users.root = {
      shell = pkgs.zsh;
      initialPassword = "root";
    };
    users.seraphybr = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "nixos";
      extraGroups = [ 
        "video" "wheel"  
        "libvirtd" "networkmanager" 
        "wireshark" "docker" "vboxusers"
      ];
    };
  };

}
