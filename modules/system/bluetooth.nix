{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.bluetooth = {
    enable = true;
    # Otherwise the adapter comes up soft-blocked and every reboot needs a
    # manual `bluetoothctl power on`.
    powerOnBoot = true;
    settings = {
      General = {
        # Battery reporting, and the codec plumbing behind hw volume control.
        Experimental = true;
        # Let a paired device that wakes up reconnect without us initiating.
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez # bluetoothctl
    bluez-tools # bt-adapter, bt-device, bt-obex
  ];

  # WirePlumber only negotiates plain SBC unless told otherwise; this gets
  # SBC-XQ for music and mSBC for headset mics, and hands volume to the device.
  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "a2dp_sink"
        "a2dp_source"
        "bap_sink"
        "bap_source"
        "hfp_ag"
        "hfp_hf"
        "hsp_ag"
        "hsp_hs"
      ];
    };
  };
}
