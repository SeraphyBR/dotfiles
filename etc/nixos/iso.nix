# To build the image: nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    # My NixOS Config
    ./overlays.nix
    ./programs.nix
    ./services.nix
    ./home.nix
  ];

  boot.kernelParams = [
    "vt.default_red=0x4c,0xff,0xa3,0xdb,0x5c,0xb9,0x27,0xff,0x63,0xf9,0x4f,0xdb,0x69,0xb9,0x70,0xff"
    "vt.default_grn=0x4c,0x6c,0xdf,0xee,0xb6,0x81,0xc3,0xff,0x83,0x54,0xda,0xee,0xc3,0x81,0x97,0xff"
    "vt.default_blu=0x4c,0x6c,0x4c,0x77,0x4f,0xf4,0xff,0xff,0xa7,0x6d,0xee,0x77,0x5c,0xf4,0xff,0xff"
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
