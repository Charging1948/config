{
  channels,
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.lunarvim;
in {
  options.plusultra.cli-apps.lunarvim = with types; {
    enable = mkBoolOpt false "Whether or not to enable lunarvim.";
  };

  config =
    mkIf cfg.enable {home.packages = with channels.unstable; [lunarvim];};
}
