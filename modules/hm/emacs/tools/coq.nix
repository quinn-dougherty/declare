{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ coq coq-lsp ];
}
