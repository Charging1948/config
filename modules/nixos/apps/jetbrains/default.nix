{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.jetbrains;
  programs = {
    "clion" = [ ];
    "webstorm" = [ ];
    "rust-rover" = [ ];
    "pycharm-professional" = [ ];
    "rider" = [ ];
    "idea-ultimate" = [ "kotlin" ];
    "goland" = [ ];
  };
  globalExtensions = [ "ini" "ideavim" "github-copilot" "darcula-pitch-black" "nixidea" ];
in
{
  options.plusultra.apps.jetbrains = with lib.types; {
    enable = mkEnableOption "Enable JetBrains IDEs";
    ides = mkOption {
      type = attrsOf (listOf str);
      default = jetbrains-idea-config.programs;
      description = "Mapping of JetBrains IDEs to their specific extensions";
    };
    extensions = mkOption {
      type = listOf str;
      default = jetbrains-idea-config.globalExtensions;
      description = "List of global Extensions to install in all IDEs";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with lib; let
      inherit (pkgs.unstable) jetbrains;
      installIde = name: extensions:
        let
          idePackage = attrByPath [ name ] null jetbrains;
          specificExtensions = cfg.ides.${name} or [ ];
          allExtensions = specificExtensions ++ cfg.extensions;
        in
        idePackage
        // (jetbrains.plugins.addPlugins idePackage allExtensions);
    in
    (mapAttrsToList installIde cfg.ides) ++ [ pkgs.gnumake ];
  };
}
