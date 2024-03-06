{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.system.fonts;
in {
  options.plusultra.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
    font = {
      regular = {
        family = mkOpt str "Fira Sans" "The regular font family.";
        package = mkOpt package pkgs.fira "The regular font package.";
      };
      monospace = {
        family = mkOpt str "FiraCode Nerd Font" "The monospace font family.";
        package =
          mkOpt package pkgs.nerdfonts.override {fonts = ["FiraCode"];}
          "The monospace font package.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        fira
        (nerdfonts.override {
          fonts = [
            "Hack"
            "FiraCode"
            "CascadiaCode"
            "IBMPlexMono"
            "Iosevka"
            "IosevkaTerm"
            "JetBrainsMono"
            "RobotoMono"
            "Terminus"
          ];
        })
      ]
      ++ cfg.fonts;
  };
}
