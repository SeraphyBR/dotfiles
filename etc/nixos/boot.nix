{ config, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_5_10;
  boot.kernelParams = [
    "vt.default_red=0x4c,0xff,0xa3,0xdb,0x5c,0xb9,0x27,0xff,0x63,0xf9,0x4f,0xdb,0x69,0xb9,0x70,0xff" 
    "vt.default_grn=0x4c,0x6c,0xdf,0xee,0xb6,0x81,0xc3,0xff,0x83,0x54,0xda,0xee,0xc3,0x81,0x97,0xff" 
    "vt.default_blu=0x4c,0x6c,0x4c,0x77,0x4f,0xf4,0xff,0xff,0xa7,0x6d,0xee,0x77,0x5c,0xf4,0xff,0xff"
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.splashImage = "/etc/nixos/boot_wallpaper.jpg"; 
  boot.loader.grub.useOSProber = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  }; 
  boot.loader.grub.extraEntries = ''
    menuentry "Funtoo Linux - vmlinuz-5.8.0-gentoo-r1-legion-y530" {
    insmod part_gpt
    insmod ext2
    set root=(hostdisk//dev/nvme0n1,gpt1)
    search --no-floppy --fs-uuid --set 0f563873-cc67-4708-8a2d-6b1b69850eec
    linux /vmlinuz-5.8.0-gentoo-r1-legion-y530 real_root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 rootflags=ssd,compress=zstd,autodefrag,subvol=/@funtoo rootfstype=btrfs rand_id=PPJKZZ4L
    initrd /early_ucode.cpio /initramfs.cpio.gz
    set gfxpayload=keep
    }

    menuentry "Funtoo Linux - vmlinuz-5.6.15-gentoo-legion-y530" {
    insmod part_gpt
    insmod ext2
    set root=(hostdisk//dev/nvme0n1,gpt1)
    search --no-floppy --fs-uuid --set 0f563873-cc67-4708-8a2d-6b1b69850eec
    linux /vmlinuz-5.6.15-gentoo-legion-y530 real_root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 rootflags=ssd,compress=zstd,autodefrag,subvol=/@funtoo rootfstype=btrfs rand_id=8I9T8CGQ
    initrd /early_ucode.cpio /initramfs.cpio.gz
    set gfxpayload=keep
    }

    menuentry "Funtoo Linux genkernel - kernel-debian-sources-x86_64-5.6.7_p1" {
    insmod part_gpt
    insmod ext2
    set root=(hostdisk//dev/nvme0n1,gpt1)
    search --no-floppy --fs-uuid --set 0f563873-cc67-4708-8a2d-6b1b69850eec
    linux /kernel-debian-sources-x86_64-5.6.7_p1 real_root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 nomodeset root=UUID=d3c28881-a752-4af7-bea5-ce443aace5f8 rootflags=ssd,compress=zstd,autodefrag,subvol=/@funtoo rootfstype=btrfs rand_id=Q0J7CV17
    initrd /early_ucode.cpio /initramfs-debian-sources-x86_64-5.6.7_p1
    set gfxpayload=keep
    }
  '';

}
