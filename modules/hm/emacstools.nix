{ inputs, config, lib, pkgs, ... }:

{
  home.packages =
    import "${inputs.self}/modules/system/emacs/tools" { inherit inputs pkgs; };
}
