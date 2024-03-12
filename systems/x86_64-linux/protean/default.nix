{
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; {
  imports = [./hardware.nix];

  plusultra = {
    suites = {
      common = enabled;
      desktop = enabled;
      development = enabled;
      art = enabled;
      video = enabled;
      social = enabled;
      media = enabled;
    };

    user = {
      name = "jk";
      fullName = "Joachim Kern";
      email = "joachim.dev@pm.me";
      initialPassword = "password";
    };

    apps = {steam = enabled;};

    # suites = {nvidia = enabled;};

    tools = {go = enabled;};

    desktop = {
      # awesome = enabled;
      # sway = enabled;
      # gnome = mkForce disabled;
      # hyprland = enabled;
    };

    virtualisation = {
      # kvm = enabled;
      # waydroid = enabled;
      podman = enabled;
    };

    # hardware = {
    #   opengl = enabled;
    #   keyboard = {
    #     enable = true;
    #     zsa = enabled;
    #     wooting = enabled;
    #   };
    # };

    # system = {boot.plymouth = enabled;};
  };

  plusultra.home.extraOptions = {
    # dconf.settings = {
    #   "org/gnome/shell/extensions/just-perfection" = {
    #     panel-size = 60;
    #   };
    # };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
