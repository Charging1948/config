{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.jetbrains;
  jetbrains-idea-config = {
    programs = [
      "clion"
      "webstorm"
      "rust-rover"
      "pycharm-professional"
      "rider"
      "idea-ultimate"
      "goland"
    ];
    extensions = ["ideavim" "github-copilot"];
  };
in {
  options.plusultra.apps.jetbrains = with types; {
    enable = mkBoolOpt false "Enable JetBrains IDEs";
    ides =
      mkOpt (listOf str) jetbrains-idea-config.programs
      "List of JetBrains IDEs to install";
    extensions =
      mkOpt (listOf str) jetbrains-idea-config.extensions
      "List of Extensions to install in all IDEs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = let
      inherit (pkgs.unstable) jetbrains;
    in
      (map
        (pkgName:
          lib.attrByPath [pkgName] null jetbrains
          // jetbrains.plugins.addPlugins jetbrains.${pkgName}
          jetbrains-idea-config.extensions)
        jetbrains-idea-config.programs)
      ++ [pkgs.gnumake];
  };
}
