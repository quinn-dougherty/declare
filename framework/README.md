# Framework (daily driver)

Includes:

- `xmonad` and `xmobar` config
- development environments for several ecosystems, which I access all at once by a `.envrc` in `$HOME`.
- I run a herc agent on my daily driver
- my `$DOOMDIR` declaring my emacs build
- `home-manager` as a module of the flake
- an action opening a pull request every week advancing the pins in `flake.lock`, which hercules builds, and I pull down from cache when I want the updates instead of building manually on the spot.
