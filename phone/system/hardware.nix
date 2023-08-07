# Written manually, not like a usual `hardware-configuration.nix` generation
{ ... }: {
  ## enable the hardware rotation sensor
  hardware.sensor.iio.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
}
