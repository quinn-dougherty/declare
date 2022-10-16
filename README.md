# NixOS build/config
[![Hercules-ci][Herc badge]][Herc link]
[![Cachix Cache][Cachix badge]][Cachix link]

[Herc badge]: https://img.shields.io/badge/Herc-CI-yellowgreen?style=plastic&logo=nixos
[Herc link]: https://hercules-ci.com/github/quinn-dougherty/configuration.nix
[Cachix badge]: https://img.shields.io/badge/Cachix-effective--altruism-blueviolet?style=plastic&logo=nixos
[Cachix link]: https://effective-altruism.cachix.org

Includes: 
- `xmonad` config
- development environments for several ecosystems, which I access all at once by a `.envrc` in `$HOME`. 
- I run a herc agent on my daily driver
- my `$DOOMDIR` declaring my emacs build
- `home-manager` as a module of the flake 
- an action opening a pull request every week advancing the pins in `flake.lock`, which hercules builds, and I pull down from cache when I want the updates. 
