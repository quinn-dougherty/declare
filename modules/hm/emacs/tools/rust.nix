{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ pkg-config rust-analyzer rustfmt clippy ];
}
