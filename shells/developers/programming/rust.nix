{ pkgs }:
with pkgs; [
  rustup
  cargo
  cargo-generate # like npm create
  cargo-binstall # like npx

  # WASM:
  wasm-pack
  wasmtime
  binaryen
  wasm-bindgen-cli
  libressl
]
