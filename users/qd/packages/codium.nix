{ pkgs }: {
  enable = true;
  package = pkgs.vscodium-fhs;
  extensions = with pkgs.vscode-extensions;
    [
      vscodevim.vim
      yzhang.markdown-all-in-one
      chenglou92.rescript-vscode
      jnoortheen.nix-ide
      esbenp.prettier-vscode
      silvenon.mdx
      ms-vscode-remote.remote-ssh
      ms-python.python
    ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "vscode-squiggle";
      publisher = "QURI";
      version = "0.3.1";
      sha256 = "113w2iis4zi4z3sqc3vd2apyrh52hbh2gvmxjr5yvjpmrsksclbd";
    }]);
}
