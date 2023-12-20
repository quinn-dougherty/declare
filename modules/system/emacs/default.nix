# # APPROPRIATED FROM github.com/hlissner/dotfiles
#
# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/hlissner/doom-emacs. This module sets it up to meet my
# particular Doomy needs.

{ config, lib, pkgs, inputs, laptop, ... }:

with lib;
let
  cfg = config.editors.emacs;
  emacsPackage =
    pkgs.emacs29; # ((pkgs.emacsPackagesFor pkgs.emacsNativeComp).emacsWithPackages (epkgs: with epkgs; [vterm]));
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
      ] ++ (import ./tools { inherit inputs pkgs; });

    # environment.sessionVariables.emacs = "${emacs}/bin/emacs";

    fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts = let
      doomrepo = pkgs.fetchFromGitHub {
        owner = "doomemacs";
        repo = "doomemacs";
        rev = "03d692f129633e3bf0bd100d91b3ebf3f77db6d1";
        sha256 = "sha256-PdQD6f+TGgu0Nf/zvmJOHzrfLC50d4pWjK2dIQIizlw=";
      };
    in mkIf cfg.doom.enable {
      installDoomEmacs.text = ''
        export HOME=/home/${laptop.username}
        export XDG_CONFIG_HOME=$HOME/.config
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           cp -r ${doomrepo} $XDG_CONFIG_HOME/emacs
           chown -R ${laptop.username}:users $XDG_CONFIG_HOME/emacs
           chmod +w -R $XDG_CONFIG_HOME/emacs
        fi
        ln -sf ${inputs.self}/modules/system/emacs/doom/ ~/.config
      '';
    };
  };
}
