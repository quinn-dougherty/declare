{ laptop, inputs, secrets, doom, ... }:
with laptop;
let modpath = "${inputs.self}/modules/hm";
in {
  imports =
    import ./imports.nix { inherit inputs system modpath username desktop; };
}
