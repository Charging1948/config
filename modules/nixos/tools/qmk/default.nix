{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.tools.qmk;
in {
  options.plusultra.tools.qmk = with types; {
    enable = mkBoolOpt false "Whether or not to enable QMK";
  };

  config = mkIf cfg.enable {
    hardware.keyboard.qmk = enabled;

    environment.systemPackages = with pkgs; [qmk keymapper];

    services.udev.packages = with pkgs; [qmk-udev-rules zsa-udev-rules];
  };
}
