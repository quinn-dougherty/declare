# NixOS build/config

[![Hercules-ci][herc badge]][herc link]
[![Cachix Cache][cachix badge]][cachix link]
[![Weekly upgrade][weekly upgrade badge]][weekly upgrade link]
[![Lint][lint badge]][lint link]

[herc badge]: https://img.shields.io/badge/Herc-CI-yellowgreen?style=plastic&logo=nixos
[herc link]: https://hercules-ci.com/github/quinn-dougherty/configuration.nix
[cachix badge]: https://img.shields.io/badge/Cachix-effective--altruism-blueviolet?style=plastic&logo=nixos
[cachix link]: https://effective-altruism.cachix.org
[weekly upgrade badge]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml/badge.svg
[weekly upgrade link]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml
[lint badge]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/lint.yml/badge.svg
[lint link]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/lint.yml

Includes:

- `xmonad` and `xmobar` config
- development environments for several ecosystems, which I access all at once by a `.envrc` in `$HOME`.
- I run a herc agent on my daily driver
- my `$DOOMDIR` declaring my emacs build
- `home-manager` as a module of the flake
- an action opening a pull request every week advancing the pins in `flake.lock`, which hercules builds, and I pull down from cache when I want the updates instead of building manually on the spot.
