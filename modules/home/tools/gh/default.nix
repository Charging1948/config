{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.tools.gh;
in {
  options.plusultra.tools.gh = with types; {
    enable = mkBoolOpt false "Whether or not to enable gh.";
  };

  config = mkIf cfg.enable {programs.gh = {enable = true;};};
}
