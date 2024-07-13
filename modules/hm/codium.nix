{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    extensions =
      with pkgs.vscode-extensions;
      [
        vscodevim.vim
        yzhang.markdown-all-in-one
        chenglou92.rescript-vscode
        jnoortheen.nix-ide
        esbenp.prettier-vscode
        ms-vscode-remote.remote-ssh
        ms-python.python
        rust-lang.rust-analyzer
        mkhl.direnv
        github.copilot
      ]
      ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-squiggle";
          publisher = "QURI";
          version = "0.9.3";
          sha256 = "sha256-dtE1k59UfmH/z7E4RKaJAPwElJ7E3Y3S2b0cnQHcs2Q=";
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
          version = "2.1.2";
          sha256 = "sha256-cjpDKrn1BhC66tNJM86cMuLrCWgxen+MfSIZ8cmzIDE=";
        }
        {
          name = "vscode-mdx";
          publisher = "unifiedjs";
          version = "1.8.1";
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
        {
          name = "viper";
          publisher = "viper-admin";
          version = "4.2.2";
          sha256 = "sha256-zaaSFfWGZhodHYzSsrVs4VVpQN6SHJQLeAe3kd8fHL0=";
        }
        {
          name = "prusti-assistant";
          publisher = "viper-admin";
          version = "0.12.5";
          sha256 = "sha256-1oReRa9YlbB6Pb2Ce4Q814OyjNYyLPrSXGgBHyeROH0";
        }
        {
          name = "lean4";
          publisher = "leanprover";
          version = "0.0.129";
          sha256 = "sha256-Exz+Z+asgXwRLQlwgSt7XlWlA4BFjlTEclv83dCmWbs=";
        }
        {
          name = "vscode-kind2";
          publisher = "kind2-mc";
          version = "0.11.1";
          sha256 = "sha256-Vn7IbHKYmaA+NfLo7PIowADSqf3y7JYxRvAl9ufA4NQ=";
        }
        {
          name = "vscode-pvs";
          publisher = "paolomasci";
          version = "1.0.65";
          sha256 = "sha256-j3RcmDkFlWLjKq4bzENoYr2rZfLo22jN/NO7OkmvBZs=";
        }
      ]);
  };
  home.packages = with pkgs; [
    jdk
    # rustup
  ]; # for prusti
}
