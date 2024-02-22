{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.hardware.fingerprint;
in {
  options.plusultra.apps.kitty = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable kitty as terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      extraConfig = ''
        font_family      FiraCode Nerd Font Mono
        bold_font        auto
        italic_font      auto
        bold_italic_font auto

        font_size 14.0
        window_padding_width 25
        #background_opacity 0.60
        #hide_window_decorations yes
        #confirm_os_window_close 0

        allow_remote_control socket-only
        listen_on unix:/tmp/kitty
      '';
    };
  };
}
