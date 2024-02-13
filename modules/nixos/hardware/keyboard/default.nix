{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.hardware.keyboard;
in
{
  options.plusultra.hardware.keyboard = with types; {
    enable = mkBoolOpt false "Whether or not to enable keyboard support.";
    enableZsa = mkBoolOpt false "Whether or not to enable zsa-keyboard support.";
    enableWooting = mkBoolOpt false "Whether or not to enable wooting-keyboards support.";
  };

  config = mkIf cfg.enable {
    hardware = {
      keyboard.zsa = mkIf cfg.enableZsa enabled;
      wooting = mkIf cfg.enableWooting enabled;
    };
    plusultra.user.extraGroups = mkIf cfg.enableWooting [ "input" ];
    environment.systemPackages = mkIf cfg.enableWooting [ pkgs.wootility ];
  };
}
