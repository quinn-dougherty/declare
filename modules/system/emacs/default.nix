{
  config,
  lib,
  pkgs,
  inputs,
  machine,
  ...
}:

with lib;
let
  cfg = config.editors.emacs;
  emacsPackage = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (
    epkgs: with epkgs; [
      vterm
      sqlite3
      emacsql
    ]
  );
in
{
  options.editors.emacs = {
    enable = mkEnableOption "emacs";
    doom.enable = mkEnableOption "doomable emacs";
    package = mkOption { default = emacsPackage; };
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
      package = emacsPackage;
    };
    environment.systemPackages =
      with pkgs;
      [
        ## Emacs itself
        binutils # native-comp needs 'as', provided by this
        emacsPackage

        ## Doom dependencies
        git
        (ripgrep.override { withPCRE2 = true; })
        gnutls # for TLS connectivity

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        (mkIf (config.programs.gnupg.agent.enable) pinentry-emacs) # in-emacs gnupg prompts
        zstd # for undo-fu-session/undo-tree compression
        gzip

        ##
        cmake
        sqlite
        # treesit
        libgcc
        gcc_multi
      ]
      ++ (import ./tools { inherit inputs pkgs; });

    environment.sessionVariables.emacs = "${emacsPackage}/bin/emacs";

    fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs.text = ''
        export HOME=/home/${machine.username}
        export XDG_CONFIG_HOME=$HOME/.config
        echo "Installing doomemacs"
        mkdir -p $XDG_CONFIG_HOME/emacs
        find $XDG_CONFIG_HOME/emacs -mindepth 1 -maxdepth 1 ! -name '.local' -exec rm -rf {} +
        cp -r ${inputs.doom}/. $XDG_CONFIG_HOME/emacs
        chown -R ${machine.username}:users $XDG_CONFIG_HOME/emacs
        chmod +w -R $XDG_CONFIG_HOME/emacs
        rm -rf $XDG_CONFIG_HOME/doom
        cp -r ${inputs.self}/modules/system/emacs/doom/ $XDG_CONFIG_HOME/
        chown -R ${machine.username}:users $XDG_CONFIG_HOME/doom
        chmod +w -R $XDG_CONFIG_HOME/doom
        echo "Running doom install"
        export PATH=${emacsPackage}/bin:${pkgs.bash}/bin:${pkgs.git}/bin:$PATH
        $XDG_CONFIG_HOME/emacs/bin/doom install --force
      '';
    };
    systemd.services.tangle-doom-config = mkIf cfg.doom.enable {
      description = "Tangle doom emacs config";
      wantedBy = [ "multi-user.target" ];
      environment = rec {
        XDG_CONFIG_HOME = "/home/${machine.username}/.config";
        EMACS = "${emacsPackage}/bin/emacs";
        DOOM = "${XDG_CONFIG_HOME}/emacs/bin/doom";
        PATH = lib.mkForce (
          lib.makeBinPath [
            pkgs.bash
            pkgs.git
            emacsPackage
          ]
          + ":/run/current-system/sw/bin:$PATH"
        );
      };
      serviceConfig =
        let
          tangle = "${inputs.self}/modules/system/emacs/tangle.sh";
        in
        {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash ${tangle}";
          User = machine.username;
        };
    };
  };
}
