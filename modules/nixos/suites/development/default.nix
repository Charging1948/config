{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.suites.development;
  apps = {
    vscode = {
      enable = true;
      enableCustomInsiders = true;
    };
    yubikey = enabled;
  };
  cli-apps = {
    tmux = enabled;
    neovim = enabled;
    yubikey = enabled;
    prisma = enabled;
    mods = enabled;
  };
in
{
  options.plusultra.suites.development = with types; {
    enable =
      mkBoolOpt false
        "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    plusultra = {
      inherit apps cli-apps;

      tools = {
        # attic = enabled;
        at = enabled;
        direnv = enabled;
        devenv = enabled;
        go = enabled;
        http = enabled;
        k8s = enabled;
        node = enabled;
        titan = enabled;
        qmk = enabled;
      };

      virtualisation = { podman = enabled; };
    };
  };
}
