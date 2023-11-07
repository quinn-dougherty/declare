{ pkgs, pkgs-stable }:
let
  mkShellName = devenvs:
    builtins.concatStringsSep "-" (map (devenv: devenv.name) devenvs);
  mkShellInputs = devenvs:
    (with pkgs; [ nixpkgs-fmt ])
    ++ (builtins.concatLists (map (shell: shell.buildInputs) devenvs));
  mkShell = devenvs:
    pkgs.mkShell {
      name = mkShellName devenvs;
      buildInputs = mkShellInputs devenvs;
    };
  mkDevShells = developers:
    (builtins.mapAttrs
      (name: developer: {
        name = name;
        value = developer;
      })
      developers);

  mkShell' = s1: s2:
    let name = "${s1.name}-${s2.name}";
    in {
      name = name;
      value = pkgs.mkShell {
        name = name;
        buildInputs = s1.value.buildInputs ++ s2.value.buildInputs;
      };
    };

  # length 2, without repetition and where order matters
  combinatorics.permute2 = l: builtins.concatMap (x: map (y: if x == y then x else mkShell' x y) l) l;
in
{
  developersWithPermutations = developers:
    (builtins.listToAttrs developers)
    // (builtins.listToAttrs (combinatorics.permute2 developers));
}
