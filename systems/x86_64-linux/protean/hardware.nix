{ config
, lib
, modulesPath
, inputs
, ...
}:
{

  imports = with inputs.nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    common-cpu-intel
    common-gpu-nvidia
    common-pc-laptop
    common-pc-laptop-ssd
    common-pc-laptop-hdd
    common-pc-laptop-acpi_call
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fb11f596-1c10-4966-97a2-ecc0c4e2b79f";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-b973a7ca-e781-4006-8f4d-ee39f82eafdb".device = "/dev/disk/by-uuid/b973a7ca-e781-4006-8f4d-ee39f82eafdb";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AA6B-5B43";
    fsType = "vfat";
  };

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/fb5c67b2-4b32-4b33-9562-5258f53783b4";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.enable = true;
  hardware.bluetooth.enable = true;

  # Nvidia
  hardware.nvidia.prime = {
    intelBusId = lib.mkDefault "PCI:0:2:0";
    nvidiaBusId = lib.mkDefault "PCI:1:0:0";
  };

}

