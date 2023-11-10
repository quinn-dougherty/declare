# NixOS configurations

[![Hercules-ci][herc badge]][herc link]
[![Cachix Cache][cachix badge]][cachix link]

[herc badge]: https://img.shields.io/badge/Herc-CI-yellowgreen?style=plastic&logo=nixos
[herc link]: https://hercules-ci.com/github/quinn-dougherty/configuration.nix
[cachix badge]: https://img.shields.io/badge/Cachix-quinn--dougherty-blueviolet?style=plastic&logo=nixos
[cachix link]: https://quinn-dougherty.cachix.org

|         Machine          | Function                                                |
| :----------------------: | :------------------------------------------------------ |
|      `risencrantz`       | phone (not daily driving yet)                           |
|      `grindenstern`      | daily driver                                            |
|   `a-guy-for-a-thing`    | hercules ci server, nextcloud (maybe router eventually) |
| `the-band-back-together` | just `homeManagerConfiguration` for an ubuntu           |

## Developer shells

I have very basic shells for modest and generic projects in rust, js, python, coq, ocaml, haskell. Suitable for bootstrapping.

```sh
nix develop github:quinn-dougherty/declare#rust
nix develop github:quinn-dougherty/declare#python
```

Including for monorepos of up to two different kits (these are examples, but you can use any permutation of the 6)

```sh
nix develop github:quinn-dougherty/declare#python-ocaml
nix develop github:quinn-dougherty/declare#js-rust
```

The shells are the only aspect of these repo that's vendored for direct usage.
