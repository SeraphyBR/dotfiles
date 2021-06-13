{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  swapDevices = [ ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d3c28881-a752-4af7-bea5-ce443aace5f8";
    fsType = "btrfs";
    options = [ "subvol=@nixos,compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0f563873-cc67-4708-8a2d-6b1b69850eec";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/94CC-916A";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Home,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Git" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Git,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Documents" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Documents,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Downloads" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Downloads,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Video" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Video,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Imagens" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Pictures,compress=zstd" ];
  };

  fileSystems."/home/seraphybr/Music" = {
    device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
    fsType = "btrfs";
    options = [ "subvol=@Music,compress=zstd" ];
  };

}
