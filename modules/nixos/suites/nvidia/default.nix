{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.suites.nvidia;
  hardware = {nvidia = enabled;};
  cli-apps = {nvidia-offload = enabled;};
in {
  options.plusultra.suites.nvidia = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common nvidia configuration.";
  };

  config = mkIf cfg.enable {plusultra = {inherit hardware cli-apps;};};
}
