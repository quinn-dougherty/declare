{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    extensions = with pkgs.vscode-extensions;
      [
        vscodevim.vim
        yzhang.markdown-all-in-one
        chenglou92.rescript-vscode
        jnoortheen.nix-ide
        esbenp.prettier-vscode
        ms-vscode-remote.remote-ssh
        ms-python.python
      ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-squiggle";
          publisher = "QURI";
          version = "0.5.0";
          sha256 = "sha256-xkl6K2F3lc8bCds4pz/tHRiuAyk8l5HRfp9nxkUj/AI=";
        }
        {
          name = "coq-lsp";
          publisher = "ejgallego";
          version = "0.1.8";
          sha256 = "sha256-FxHD5/lXh0ZRrQwegaJnUyWqPOkutun52CGCmGdwi7E=";
        }
        {
          name = "vscoq";
          publisher = "maximedenes";
          version = "2.0.2";
          sha256 = "sha256-pmvc1Snmxc4MWtbagZ8t2MahWQRhmy66gUM0wqB5qrk=";
        }
        {
          name = "vscode-mdx";
          publisher = "unifiedjs";
          version = "1.4.0";
          sha256 = "sha256-qqqq0QKTR0ZCLdPltsnQh5eTqGOh9fV1OSOZMjj4xXg=";
        }
        {
          name = "vscode-direnv";
          publisher = "cab404";
          version = "1.0.0";
          sha256 = "sha256-+nLH+T9v6TQCqKZw6HPN/ZevQ65FVm2SAo2V9RecM3Y=";
        }
        {
          name = "nix-extension-pack";
          publisher = "pinage404";
          version = "3.0.0";
          sha256 = "sha256-cWXd6AlyxBroZF+cXZzzWZbYPDuOqwCZIK67cEP5sNk=";
        }
      ]);
  };
}