{ config, pkgs, options,... }:

{
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
