{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.noisetorch;
in {
  options.plusultra.apps.noisetorch = with types; {
    enable = mkBoolOpt false "Whether or not to enable Noisetorch.";
  };

  config = mkIf cfg.enable { programs.noisetorch = enabled; };
}
