# NixOS configurations

[![Hercules-ci][herc badge]][herc link]
[![Cachix Cache][cachix badge]][cachix link]
[![Weekly upgrade][weekly upgrade badge]][weekly upgrade link]

[herc badge]: https://img.shields.io/badge/Herc-CI-yellowgreen?style=plastic&logo=nixos
[herc link]: https://hercules-ci.com/github/quinn-dougherty/configuration.nix
[cachix badge]: https://img.shields.io/badge/Cachix-effective--altruism-blueviolet?style=plastic&logo=nixos
[cachix link]: https://effective-altruism.cachix.org
[weekly upgrade badge]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml/badge.svg
[weekly upgrade link]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml

Includes

- `framework` (daily driver)
- `agent` (hercules ci agent)

## _todo_

- Daily driver: improve my secrets ergonomics with [`sops-nix`](https://github.com/Mic92/sops-nix) or `agenix`
- Daily driver (home-manager): less stuff be imperatively managed in `~/.config`
- New project: a [matrix](https://www.foxypossibilities.com/2018/02/04/running-matrix-synapse-on-nixos/) server
- Continuously deliver the herc agent (with hercules effects)
