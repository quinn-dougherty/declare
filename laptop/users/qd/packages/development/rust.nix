{ pkgs }:
with pkgs; [
  rustup
  cargo
  cargo-generate
  wasm-pack
  rustfmt
  rust-analyzer
  wasmtime
  binaryen
  wasm-bindgen-cli
  pkg-config
  libressl
]
