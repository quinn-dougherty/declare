{ inputs, config, lib, pkgs, ... }:

{
  home.packages =
    import "${inputs.self}/packages/emacs/tools" { inherit inputs pkgs; };
}
