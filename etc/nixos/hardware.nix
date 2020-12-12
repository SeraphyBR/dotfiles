{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.nvidia.prime = {
    offload.enable = true;

      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
  };

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/d3c28881-a752-4af7-bea5-ce443aace5f8";
      fsType = "btrfs";
      options = [ "subvol=@nixos,compress=zstd" ];
    };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/0f563873-cc67-4708-8a2d-6b1b69850eec";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" =
      { device = "/dev/disk/by-uuid/94CC-916A";
      fsType = "vfat";
    };

    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Home,compress=zstd" ];
    };

    fileSystems."/home/seraphybr/Git" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Git,compress=zstd" ];
    };

    fileSystems."/home/seraphybr/Documentos" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Documents,compress=zstd" ];
    };

    fileSystems."/home/seraphybr/Video" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Video,compress=zstd" ];
    };

    fileSystems."/home/seraphybr/Imagens" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Pictures,compress=zstd" ];
    };

    fileSystems."/home/seraphybr/Music" =
      { device = "/dev/disk/by-uuid/857bf02f-6401-4ba4-aa36-3dcdca77fb32";
      fsType = "btrfs";
      options = [ "subvol=@Music,compress=zstd" ];
    };

  }
