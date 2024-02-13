{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.tools.devenv;
in
{
  options.plusultra.tools.devenv = with types; {
    enable = mkBoolOpt false "Whether or not to enable devenv.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      devenv
    ];
  };
}
