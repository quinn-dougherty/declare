{ pkgs }:
with pkgs; [
  rustup
  # rust-analyzer
  cargo
  cargo-generate # like npm create
  cargo-binstall # like npx
  cargo-risczero

  # WASM:
  wasm-pack
  wasmtime
  binaryen
  wasm-bindgen-cli
  libressl
]
