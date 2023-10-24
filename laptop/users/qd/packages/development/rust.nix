{ pkgs }:
with pkgs; [
  rustup
  cargo
  cargo-generate
  wasm-pack
  rustfmt
  clippy
  rust-analyzer
  wasmtime
  binaryen
  wasm-bindgen-cli
  pkg-config
  libressl
]
