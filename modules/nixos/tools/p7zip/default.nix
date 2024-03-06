{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.tools.p7zip;
in {
  options.plusultra.tools.p7zip = with types; {
    enable = mkBoolOpt false "Whether or not to enable p7zip.";
  };

  config =
    mkIf cfg.enable {environment.systemPackages = with pkgs; [p7zip];};
}
