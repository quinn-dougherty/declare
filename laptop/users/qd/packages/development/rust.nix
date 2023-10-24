{ pkgs }:
with pkgs; [
  rustup
  cargo
  cargo-generate
  wasm-pack
  wasmtime
  binaryen
  wasm-bindgen-cli
  libressl
]
