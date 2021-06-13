{ config, lib, pkgs, ... }:

# Nvidia Related settings
{

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    #offload.enable = true;
    sync.enable = true;

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
      # Manualy setting dpi, for nvidia prime sync
      dpi = 96;
    };

  }
