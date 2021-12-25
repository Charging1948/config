inputs@{ pkgs, lib, ... }:

{
  imports = [
    # Hardware configuration for the system.
    ./hardware.nix

    # Presets
    ../../../presets/nix.nix
    ../../../presets/boot.nix
    ../../../presets/locale.nix
    ../../../presets/gnome.nix
    ../../../presets/networking.nix
    ../../../presets/audio.nix
    ../../../presets/fonts.nix
    ../../../presets/dev.nix

    # Users
    ../../../users/short
  ];

  # Enable DHCP on the wireless link
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
