{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.virtualisation.waydroid;
in {
  options.plusultra.virtualisation.waydroid = with types; {
    enable = mkBoolOpt false "Whether or not to enable Waydroid.";
  };

  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = with pkgs; [
      # Add wl-clipboard for clipboard sharing
      wl-clipboard
    ];
  };
}
