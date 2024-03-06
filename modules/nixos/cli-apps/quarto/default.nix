{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.quarto;
in {
  options.plusultra.cli-apps.quarto = with types; {
    enable = mkBoolOpt false "Whether or not to enable Quarto.";
  };

  config =
    mkIf cfg.enable {environment.systemPackages = with pkgs; [quarto];};
}
