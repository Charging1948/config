{
  description = "Plus Ultra";

  inputs = {
    # NixPkgs (nixos-23.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (release-23.11)
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Support (master)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Lib
    snowfall-lib.url = "github:snowfallorg/lib/fix/home-module-imports";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake?ref=v1.2.0";
    flake.inputs.nixpkgs.follows = "unstable";

    # Snowfall Thaw
    thaw.url = "github:snowfallorg/thaw?ref=v1.0.5";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "unstable";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "unstable";

    # Neovim
    neovim.url = "github:Charging1948/neovim";
    neovim.inputs.nixpkgs.follows = "unstable";

    # Tmux
    tmux.url = "github:Charging1948/tmux";
    tmux.inputs = {
      nixpkgs.follows = "nixpkgs";
      unstable.follows = "unstable";
    };

    # Devenv
    devenv.url = "github:cachix/devenv";

    # Nix-Colors
    nix-colors.url = "github:misterio77/nix-colors";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Hyprland
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "unstable";
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "unstable";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # VSCode-Extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # Binary Cache
    attic = {
      url = "github:zhaofengli/attic";

      # FIXME: A specific version of Rust is needed right now or
      # the build fails. Re-enable this after some time has passed.
      inputs.nixpkgs.follows = "unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    # Vault Integration
    vault-service = {
      url = "github:DeterminateSystems/nixos-vault-service";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Hygiene
    flake-checker = {
      url = "github:DeterminateSystems/flake-checker";
      inputs.nixpkgs.follows = "unstable";
    };

    # Discord Replugged
    replugged.url = "github:LunNova/replugged-nix-flake";
    replugged.inputs.nixpkgs.follows = "unstable";

    # Discord Replugged plugins / themes
    discord-tweaks = {
      url = "github:NurMarvin/discord-tweaks";
      flake = false;
    };
    discord-nord-theme = {
      url = "github:DapperCore/NordCord";
      flake = false;
    };

    # Cows!
    cowsay = {
      url = "github:snowfallorg/cowsay?ref=v1.3.0";
      # TODO: Cowsay currently requires a newer version of ttyd that works
      # around an issue with whitespace coloring. Until that is fixed,
      # we won't be able to specify a unique nixpkgs value safely.
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Backup management
    icehouse = {
      url = "github:snowfallorg/icehouse?ref=v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Yubikey Guide
    yubikey-guide = {
      url = "github:drduh/YubiKey-Guide";
      flake = false;
    };

    # GPG default configuration
    gpg-base-conf = {
      url = "github:drduh/config";
      flake = false;
    };

    bibata-cursors = {
      url = "github:suchipi/Bibata_Cursor";
      flake = false;
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hosted Sites
    lasersandfeelings = {
      url = "github:jakehamilton/lasersandfeelings";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    pungeonquest = {
      url = "github:jakehamilton/pungeonquest";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    scrumfish = {
      url = "github:jakehamilton/scrumfi.sh";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    retrospectacle = {
      url = "github:jakehamilton/retrospectacle.app";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    jakehamilton-website = {
      url = "github:jakehamilton/jakehamilton.dev";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    noop-ai-website = {
      url = "github:noopai/noop.ai";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };
    sokoban-app-website = {
      url = "https://github.com/jakehamilton/sokoban.app/releases/download/v1/sokoban.app.tar.gz";
      flake = false;
    };
    snowfall-docs = {
      url = "github:snowfallorg/docs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-news = {
      url = "github:jakehamilton/nixpkgs.news";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "plusultra";
          title = "Plus Ultra";
        };

        namespace = "plusultra";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        # TODO: Test building now, as system is using 23.11
        # permittedInsecurePackages = [
        #   # FIXME: This is a workaround for 22.11 and can
        #   # be removed once NixPkgs is upgraded to 23.05.
        #   "python-2.7.18.6"
        #   "electron-25.9.0"
        # ];
      };

      overlays = with inputs; [
        neovim.overlays.default
        tmux.overlay
        flake.overlays.default
        thaw.overlays.default
        cowsay.overlays.default
        icehouse.overlays.default
        attic.overlays.default
        snowfall-docs.overlay
        nix-gaming.overlays.default
        devenv.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nix-ld.nixosModules.nix-ld
        vault-service.nixosModules.nixos-vault-service

        # NixOS Tweaks for gaming
        nix-gaming.nixosModules.pipewireLowLatency
        nix-gaming.nixosModules.steamCompat

        # TODO: Replace plusultra.services.attic now that vault-agent
        # exists and can force override environment files.
        # attic.nixosModules.atticd
      ];

      systems.hosts.jasper.modules = with inputs; [nixos-hardware.nixosModules.framework-11th-gen-intel];

      deploy = lib.mkDeploy {inherit (inputs) self;};

      checks =
        builtins.mapAttrs
        (system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy)
        inputs.deploy-rs.lib;
    };
}
