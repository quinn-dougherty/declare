{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    openai
    jupyter
    black
    poetry
    python311Packages.jupyterlab
    python311Packages.jedi-language-server
  ];
}