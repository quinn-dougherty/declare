{ pkgs }:
with pkgs; [
  rustup
  cargo
  cargo-generate
  wasm-pack
  rustfmt
  rust-analyzer
]
