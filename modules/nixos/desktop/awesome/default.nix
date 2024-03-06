{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.desktop.awesome;
  inherit (config.plusultra.desktop.addons) term;
in {
  options.plusultra.desktop.awesome = with types; {
    enable = mkBoolOpt false "Whether or not to enable Awesome.";
    # wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
    # extraConfig =
    #   mkOpt str "" "Additional configuration for the Awesome config file.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    plusultra.desktop.addons = {
      gtk = enabled;
      kitty = enabled;
      mako = enabled;
      rofi = enabled;
      keyring = enabled;
      nautilus = enabled;
      xdg-portal = enabled;
      electron-support = enabled;
    };

    services.xserver = {
      windowManager.awesome = {enable = true;};
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
        defaultSession = "awesome";
      };
    };

    plusultra.home.file.".config/awesome" = {
      source = ./awesome;
      recursive = true;
    };
  };
}
