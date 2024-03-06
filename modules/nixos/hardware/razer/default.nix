{
  options,
  config,
  pkgs,
  lib,
  channels,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.hardware.razer;
in {
  options.plusultra.hardware.razer = with types; {
    enable = mkBoolOpt false "Whether or not to enable razer hardware support.";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = ["button.lid_init_state=open"];

    hardware.openrazer = {
      enable = true;
      devicesOffOnScreensaver = false;
      users = [config.plusultra.user.name];
    };

    environment.systemPackages = with channels.unstable; [
      openrazer-daemon
      polychromatic
    ];
  };
}
