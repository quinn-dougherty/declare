{ pkgs }:
with pkgs;
[
  rustup
  # rust-analyzer
  cargo
  cargo-generate # like npm create
  cargo-binstall # like npx

  # WASM:
  wasm-pack
  wasmtime
  binaryen
  wasm-bindgen-cli
  # Cargo dependencies
  libressl
  pkg-config
]
