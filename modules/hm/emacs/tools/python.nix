{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; let pypkgs = ps: with ps; [ jupyterlab jedi-language-server ]; in [
    (python311.withPackages pypkgs)
    openai
    jupyter
    black
    poetry
  ];
}
