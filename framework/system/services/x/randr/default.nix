let fingerprints = import ./fingerprints.nix;
in {
  enable = true;
  profiles = {
    duo-hdmi = {
      config = {
        eDP-1 = {
          enable = true;
          primary = false;
          position = "1920x0";
          mode = "2256x1504";
          crtc = 1;
        };
        DP-1.enable = false;
        DP-2.enable = false;
        DP-3 = {
          enable = true;
          primary = true;
          position = "0x0";
          mode = "1920x1080";
          crtc = 0;
        };
        DP-4.enable = false;
      };
      fingerprint = {
        DP-3 = fingerprints.DP-3;
        eDP-1 = fingerprints.eDP-1;
      };
    };
    duo = {
      config = {
        eDP-1 = {
          enable = true;
          primary = false;
          position = "3440x0";
          mode = "2256x1504";
          crtc = 1;
        };
        DP-1.enable = false;
        DP-2.enable = false;
        DP-3.enable = false;
        DP-4 = {
          enable = true;
          primary = true;
          position = "0x0";
          mode = "3440x1440";
          crtc = 0;
        };
      };
      fingerprint = {
        DP-4 = fingerprints.DP-4;
        eDP-1 = fingerprints.eDP-1;
      };
    };
    solo = {
      config = {
        eDP-1 = {
          enable = true;
          primary = true;
          position = "0x0";
          mode = "2256x1504";
          crtc = 0;
        };
        DP-1.enable = false;
        DP-2.enable = false;
        DP-3.enable = false;
        DP-4.enable = false;
      };
      fingerprint.eDP-1 = fingerprints.eDP-1;
    };
  };
}
