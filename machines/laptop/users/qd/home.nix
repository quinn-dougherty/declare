{ laptop, inputs, secrets, ... }:
with laptop;
let modpath = "${inputs.self}/modules/hm";
in {
  imports =
    import ./imports.nix { inherit inputs system modpath username desktop; };
}
