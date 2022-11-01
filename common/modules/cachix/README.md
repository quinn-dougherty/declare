# This is a departure from standard `cachix use` usage.

```sh
mkdir tmp
sudo cachix use <cache-name> -d tmp
mv tmp/cachix/<cache-name>.nix ~/Dropbox/dotfiles/common/modules/cachix
rm tmp/*`
```

You'll need to rerun `nixfmt common/modules/cachix/<cachix-name>.nix`.
