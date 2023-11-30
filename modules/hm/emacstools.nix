{ inputs, config, lib, pkgs, ... }:

{
  home.packages =
    import "${inputs.self}/modules/emacs/tools" { inherit inputs pkgs; };
}
