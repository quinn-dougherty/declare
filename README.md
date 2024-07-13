# NixOS configurations

[![Built With Nix][bwn badge]][bwn link]

[bwn badge]: https://builtwithnix.org/badge.svg
[bwn link]: https://builtwithnix.org

|     Machine      | Function                                                                   |
| :--------------: | :------------------------------------------------------------------------- |
|     `corise`     | phone (not daily driving yet)                                              |
|      `rise`      | daily driver (framework 13 batch 5)                                        |
|     `grind`      | hercules ci server, nextcloud (maybe router eventually) (onprem)           |
|    `cogrind`     | monitor `a-guy-for-a-thing`, plus other services with digital ocean uptime |
| `cogrindenstern` | just `homeManagerConfiguration` for an ubuntu                              |

## Developer shells

I have very basic shells for modest and generic projects in rust, js, python, coq, ocaml, haskell. Suitable for bootstrapping.

```sh
nix develop github:quinn-dougherty/declare#rust
nix develop github:quinn-dougherty/declare#python
```

Including for monorepos of up to three different kits (these are examples, but you can use any permutation of the 6)

```sh
nix develop github:quinn-dougherty/declare#python-ocaml
nix develop github:quinn-dougherty/declare#js-rust
nix develop github:quinn-dougherty/declare#haskell-coq-js
nix develop github:quinn-dougherty/declare#python-rust-js
```

The shells are the only aspect of these repo that's vendored for direct usage.
