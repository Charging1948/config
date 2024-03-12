default:
	just --list

# Update flake inputs
update:
  nix flake update

# Update single flake input
update-input input="neovim-flake":
  nix flake lock --update-input "{{input}}"

# Rebuild the system
rebuild method="switch" system="protean":
  sudo nixos-rebuild --flake ".#{{system}}" {{method}}
