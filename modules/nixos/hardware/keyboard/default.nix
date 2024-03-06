{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.hardware.keyboard;
in {
  options.plusultra.hardware.keyboard = with types; {
    enable = mkBoolOpt false "Whether or not to enable keyboard support.";
    zsa.enable =
      mkBoolOpt false "Whether or not to enable zsa-keyboard support.";
    wooting.enable =
      mkBoolOpt false "Whether or not to enable wooting-keyboards support.";
  };

  config = mkIf cfg.enable {
    hardware = {
      keyboard.zsa = mkIf cfg.zsa.enable enabled;
      wooting = mkIf cfg.wooting.enable enabled;
    };
    plusultra.user.extraGroups = ["input"];
    environment.systemPackages = mkIf cfg.wooting.enable [pkgs.wootility];
  };
}
