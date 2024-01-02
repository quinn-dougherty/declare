{ inputs, ... }:
let modpath = "${inputs.self}/modules/hm";
in { imports = import ./imports.nix { inherit modpath; }; }
