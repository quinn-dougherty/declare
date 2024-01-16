# # APPROPRIATED FROM github.com/hlissner/dotfiles

{ config, lib, pkgs, inputs, laptop, ... }:

with lib;
let
  cfg = config.editors.emacs;
  emacsPackage = ((pkgs.emacsPackagesFor pkgs.emacsNativeComp).emacsWithPackages
    (epkgs: with epkgs; [ vterm ]));
in {
  options.editors.emacs = {
    enable = mkEnableOption "emacs";
    doom.enable = mkEnableOption "doomable emacs";
    package = mkOption { default = emacsPackage; };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    environment.systemPackages = with pkgs;
      [
        ## Emacs itself
        binutils # native-comp needs 'as', provided by this
        # 28.2 + native-comp
        emacsPackage

        ## Doom dependencies
        git
        (ripgrep.override { withPCRE2 = true; })
        gnutls # for TLS connectivity

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        (mkIf (config.programs.gnupg.agent.enable)
          pinentry-emacs) # in-emacs gnupg prompts
        zstd # for undo-fu-session/undo-tree compression

        ##
        cmake
        sqlite
        # libgcc # This isn't helping vterm compile, yet.
      ] ++ (import ./tools { inherit inputs pkgs; });

    environment.sessionVariables.emacs = "${emacsPackage}/bin/emacs";

    fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs.text = ''
        export HOME=/home/${laptop.username}
        export XDG_CONFIG_HOME=$HOME/.config
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           cp -r ${inputs.doom} $XDG_CONFIG_HOME/emacs
           chown -R ${laptop.username}:users $XDG_CONFIG_HOME/emacs
           chmod +w -R $XDG_CONFIG_HOME/emacs
        fi
        rm -rf $XDG_CONFIG_HOME/doom
        cp -r ${inputs.self}/modules/system/emacs/doom/ $XDG_CONFIG_HOME/
        chown -R ${laptop.username}:users $XDG_CONFIG_HOME/doom
        chmod +w -R $XDG_CONFIG_HOME/doom
        $XDG_CONFIG_HOME/emacs/bin/doom install
      '';
    };
  };
}
