{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.cli-apps.wine;
in {
  options.plusultra.cli-apps.wine = with types; {
    enable = mkBoolOpt false "Whether or not to enable Wine.";
    enableBottles = mkBoolOpt false "Whether or not to enable Wine bottles.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [winePackages.unstable winetricks wine64Packages.unstable]
      ++ (lib.optionals cfg.enableBottles [bottles.unstable]);
  };
}
