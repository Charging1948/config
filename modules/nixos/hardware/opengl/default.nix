{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.hardware.opengl;
in {
  options.plusultra.hardware.opengl = with types; {
    enable = mkBoolOpt false "Whether or not to enable opengl support.";
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        intel-compute-runtime
      ];
    };
  };
}
