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
      # silvenon.mdx # deprecated, wait for https://marketplace.visualstudio.com/items?itemName=unifiedjs.vscode-mdx I guess
      ms-vscode-remote.remote-ssh
      ms-python.python
    ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "vscode-squiggle";
      publisher = "QURI";
      version = "0.5.0";
      sha256 = "sha256-xkl6K2F3lc8bCds4pz/tHRiuAyk8l5HRfp9nxkUj/AI=";
    }]);
}
