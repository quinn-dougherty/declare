# NixOS configurations

[![Hercules-ci][herc badge]][herc link]
[![Cachix Cache][cachix badge]][cachix link]
[![Weekly upgrade][weekly upgrade badge]][weekly upgrade link]

[herc badge]: https://img.shields.io/badge/Herc-CI-yellowgreen?style=plastic&logo=nixos
[herc link]: https://hercules-ci.com/github/quinn-dougherty/configuration.nix
[cachix badge]: https://img.shields.io/badge/Cachix-quinn--dougherty-blueviolet?style=plastic&logo=nixos
[cachix link]: https://quinn-dougherty.cachix.org
[weekly upgrade badge]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml/badge.svg
[weekly upgrade link]: https://github.com/quinn-dougherty/configuration.nix/actions/workflows/upgrade.yml

Includes

- `framework` (daily driver)
- `agent` (hercules ci agent)
  - I have a dormant one for Digital Ocean, that I'm keeping in the codebase (with effect triggers set to `false`) just in case I need to spin up an agent on a droplet some day.
  - My actual agent that builds my repos is `agent-latitude`.
- `chat` (matrix server)
  - (Not deployed as of this writing, making decisions about that).
