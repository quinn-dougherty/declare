{
  secrix = {
    services = {
      hci-default.secrets = {
        "binary-caches.json".encrypted.file = ./herc/binary-caches.json.age;
        "secrets.json".encrypted.file = ./herc/secrets.json.age;
        "cluster-join-token.key".encrypted.file =
          ./herc/cluster-join-token.key.age;
      };
      hci-default.secretsDirName = "hci-default-keys";
      hci-casper.secrets = {
        "binary-caches.json".encrypted.file = ./herc/binary-caches.json.age;
        "secrets.json".encrypted.file = ./herc/secrets.json.age;
        "cluster-join-token.key".encrypted.file =
          ./herc/cluster-join-token-casper.key.age;
      };
      hci-casper.secretsDirName = "hci-casper-keys";
      nextcloud.secrets."nextcloud-db-pass".encrypted.file =
        ./nextcloud-db-pass.age;
      nix-serve.secrets."cache-qd-priv-key.pem" = {
        encrypted.file = ./cache-qd-priv-key.pem.age;
        decrypted.mode = "0600";
      };
    };
    system.secrets = {
      "factorio-token" = {
        encrypted.file = ./factorio-token.age;
        decrypted.builder = ''
          mkdir -p /var/lib/factorio
          ln -s $inFile /var/lib/factorio/token
        '';
      };
      "quinnd-riseup-pass".encrypted.file = ./quinnd-riseup-pass.age;
      # "qd92-gmail-pass".encrypted.file = ./qd92-gmail-pass.age;
    };
  };
}
