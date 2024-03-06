{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.desktop.addons.kitty;
in {
  options.plusultra.apps.kitty = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable kitty as terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}
