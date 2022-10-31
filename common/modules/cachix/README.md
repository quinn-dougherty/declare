# `sudo cachix use <cache-name> -d tmp && mv tmp/cachix/<cache-name>.nix ~/Dropbox/dotfiles/common/modules/cachix && rm tmp/*`

You'll need to rerun `nixfmt common/modules/cachix/*.nix` every time you `cachix use`.
