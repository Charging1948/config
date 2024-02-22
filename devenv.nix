{
  pkgs,
  lib,
  config,
  ...
}: {
  scripts.pull-upstream.exec = ''
    var=`git branch --show-current`
    echo "current git-branch -> $var"
  '';

  enterShell = ''
    echo
    echo 🦾 Helper scripts you can run to make your development richer:
    echo 🦾
    ${pkgs.gnused}/bin/sed -e 's| |••|g' -e 's|=| |' <<EOF | ${pkgs.util-linuxMinimal}/bin/column -t | ${pkgs.gnused}/bin/sed -e 's|^|🦾 |' -e 's|••| |g'
    ${lib.generators.toKeyValue {}
      (lib.mapAttrs (name: value: value.description) config.scripts)}
    EOF
    echo
  '';
  # https://devenv.sh/languages/
  languages.nix.enable = true;
  languages.haskell.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks.alejandra.enable = true;
  pre-commit.hooks.nil.enable = true;
}
