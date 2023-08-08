# Written manually, not like a usual `hardware-configuration.nix` generation
{ ... }: {
  ## enable the hardware rotation sensor
  hardware = {
    sensor.iio.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };
}
