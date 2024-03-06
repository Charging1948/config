{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.plusultra.cli-apps.zsh;
in {
  options.plusultra.cli-apps.zsh = {enable = mkEnableOption "ZSH";};

  config = mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        syntaxHighlighting = {
          enable = true;
          highlighters = ["main" "brackets" "regexp" "root" "line"];
        };

        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "thefuck"
            "direnv"
            "docker"
            "docker-compose"
            "fzf"
            "tmux"
            "zoxide"
            "magic-enter"
            "colored-man-pages"
            "common-aliases"
            "aliases"
            "zoxide"
            "tmuxinator"
          ];
        };

        initExtra = ''
          # Fix an issue with tmux.
          export KEYTIMEOUT=1

          # Use vim bindings.
          set -o vi

          ${pkgs.toilet}/bin/toilet -f future "Plus Ultra" --gay

          # Improved vim bindings.
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        '';

        shellAliases = {
          say = "${pkgs.toilet}/bin/toilet -f pagga";
          fvim = "nix run github:charging1948/neovim";
        };

        plugins = [pkgs.zsh-nix-shell];
      };

      starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red) ";
            vicmd_symbol = "[](bold blue) ";
          };
        };
      };
    };
    home.packages = with pkgs; [
      fzf
      thefuck
      zoxide
      direnv
      tmuxinator
      zoxide
      tmux-cssh
    ];
  };
}
