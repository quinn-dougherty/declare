{
  config,
  lib,
  pkgs,
  ...
}:

{
  mobile.boot.stage-1 = {
    networking.enable = lib.mkDefault true;
    kernel.useStrictKernelConfig = lib.mkDefault true;
  };
}
