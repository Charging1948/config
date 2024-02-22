{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.tools.just;
in {
  options.plusultra.tools.just = with types; {
    enable = mkBoolOpt false "Whether or not to enable just.";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [just];};
}
