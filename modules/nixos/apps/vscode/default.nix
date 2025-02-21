{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.apps.vscode;
in {
  options.plusultra.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
    enableCustomInsiders =
      mkBoolOpt false
      "Whether or not to enable vscode-insiders with extensions.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
      (lib.optionals cfg.enableInsidersWithExtensions
        vscode-with-extensions.override
        {
          vscode =
            (pkgs.vscode.override {isInsiders = true;}).overrideAttrs
            (oldAttrs: rec {
              src = builtins.fetchTarball {
                url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
                # sha256 = "0rxd85xgwyszjjziniby867xzrg7mqx81nq7np9j2kdvkhaf992y";
                sha256 = lib.fakeSha256;
              };
              version = "latest";

              buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
            });
          vscodeExtensions = with extensions; [
            open-vsx.asvetliakov.vscode-neovim
            open-vsx.wakatime.vscode-wakatime
            open-vsx.ms-python.python
            open-vsx.ms-toolsai.jupyter
            open-vsx.ms-toolsai.jupyter-renderers
            open-vsx.ms-toolsai.jupyter-keymap
            open-vsx.ms-toolsai.vscode-jupyter-cell-tags
            open-vsx.ms-toolsai.vscode-jupyter-slideshow
            open-vsx.catppuccin.catppuccin-vsc
            open-vsx.astro-build.astro-vscode
            open-vsx.graphql.vscode-graphql
            open-vsx.quarto.quarto
            open-vsx.rust-lang.rust-analyzer
            open-vsx.jnoortheen.nix-ide
            open-vsx.mkhl.direnv
            vscode-marketplace.github.copilot
            vscode-marketplace.github.copilot-chat
            vscode-marketplace.ms-vscode-remote.remote-containers
            # vscode-marketplace.
            # open-vsx.
          ];
        })
    ];
  };
}
