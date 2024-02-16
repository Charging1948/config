{ options, config, pkgs, lib, ... }:
with lib;
with lib.plusultra;
let cfg = config.plusultra.system.boot;
in {
  options.plusultra.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
    enablePlymouth = mkBoolOpt false "Whether or not to enable Plymouth.";
  };

  config = mkIf cfg.enable {
    boot = {

      loader = {

        efi.canTouchEfiVariables = true;

        systemd-boot = {

          enable = true;
          configurationLimit = 10;

          # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
          editor = false;
        };
      };
    } // lib.mkIf cfg.enablePlymouth {
      # Enable Plymouth if the option is set
      boot = {
        plymouth.enable = true;
        initrd.systemd.enable = true;
        kernelParams = [ "quiet" ];
      };
    };
  };
}
