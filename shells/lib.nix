{ pkgs, pkgs-stable }:
let
  mkShellName = devenvs:
    builtins.concatStringsSep "-" (map (devenv: devenv.name) devenvs);
  mkShellInputs = devenvs:
    (with pkgs; [ nixpkgs-fmt ])
    ++ (builtins.concatLists (map (shell: shell.buildInputs) devenvs));

  nixpkgsSwitch = switch: if switch == "stable" then pkgs-stable else pkgs;

  mkDevShell = s1: s2:
    let name = "${s1.name}-${s2.name}";
    in {
      name = name;
      value = pkgs.mkShell {
        name = name;
        buildInputs = s1.value.buildInputs ++ s2.value.buildInputs;
      };
    };

  combinatorics = rec {
    permute2 = l:
      builtins.concatMap (x: map (y: if x == y then x else mkDevShell x y) l) l;
    permute3 = l:
      with builtins;
      concatMap
        (x:
          let perms = permute2 (filter (x': x != x') l);
          in map (y: mkDevShell x y) perms)
        l;
  };
in
{
  developersWithPermutations = developers:
    with builtins;
    (listToAttrs developers)
    // (listToAttrs (combinatorics.permute2 developers))
    // (listToAttrs (combinatorics.permute3 developers));

  mkShell = development:
    pkgs.mkShell {
      name = "${development.name}-developer";
      buildInputs = import ./developers/programming/${development.name}.nix {
        pkgs = nixpkgsSwitch development.nixpkgsSwitch;
      };
    };
}
