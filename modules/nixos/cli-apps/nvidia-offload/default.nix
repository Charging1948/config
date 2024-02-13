{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.cli-apps.nvidia-offload;
in
{
  options.plusultra.cli-apps.nvidia-offload = with types; {
    enable = mkBoolOpt false "Whether or not to enable Nvidia-offload.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvidia-offload
    ];
  };
}
