{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.hardware.nvidia;
in {
  options.plusultra.hardware.nvidia = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable nvidia-graphics support.";
    enablePowerSpecialisations =
      mkBoolOpt false
      "Whether or not to enable additional Specialisations that allow for powersaving and high-performance respectively.";
  };

  config = mkIf cfg.enable {
    imports = with inputs.nixos-hardware.nixosModules; [common-gpu-nvidia];

    boot.kernelParams = ["nvidia_drm.modeset=1"];
    hardware.nvidia = {
      modesetting.enable = lib.mkDefault true;
      prime = {
        reverseSync = lib.mkDefault true;
        allowExternalGpu = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    services.thermald.enable = lib.mkDefault true;

    specialisation = mkIf cfg.enablePowerSpecialisations {
      # Enable Sync Mode for maximum performance
      high-performance.configuration = let
        mkAlmostForce = lib.mkOverride 102;
      in {
        system.nixos.tags = ["high-performance"];

        hardware.nvidia.prime = {
          offload.enable = mkAlmostForce false;
          offload.enableOffloadCmd = mkAlmostForce false;
          reverseSync.enable = mkAlmostForce false;
          sync.enable = mkAlmostForce true;
        };
        services.thermald.enable = lib.mkForce false;
        powerManagement.cpuFreqGovernor = lib.mkForce "performance";
      };

      # Completely disable nvidia card to save battery.
      on-the-go.configuration = {
        system.nixos.tags = ["on-the-go"];
        imports = with inputs.nixos-hardware.nixosModules; [common-gpu-nvidia-disable];

        hardware.nvidiaOptimus.disable = true;
        hardware.nvidia.prime = with lib; {
          offload.enable = mkForce false;
          offload.enableOffloadCmd = mkForce false;
          reverseSync.enable = mkForce false;
          sync.enable = mkForce false;
        };
        boot.extraModprobeConfig = lib.mkForce ''
          blacklist nouveau
          options nouveau modeset=0
        '';

        services.udev.extraRules = lib.mkForce ''
          # Remove NVIDIA USB xHCI Host Controller devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA USB Type-C UCSI devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA Audio devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA VGA/3D controller devices
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
        '';
        boot.blacklistedKernelModules =
          lib.mkForce ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"];
      };
    };
  };
}
