{
  secrix = {
    services = {
      hercules-ci-agent.secrets = {
        "binary-caches.json".encrypted.file = ./herc/binary-caches.json.age;
        "secrets.json".encrypted.file = ./herc/secrets.json.age;
        "cluster-join-token.key".encrypted.file =
          ./herc/cluster-join-token.key.age;
      };
      nextcloud.secrets = {
        "nextcloud-db-pass".encrypted.file = ./nextcloud-db-pass.age;
      };
      nix-serve.secrets."cache-qd-priv-key.pem" = {
        encrypted.file = ./cache-qd-priv-key.pem.age;
        decrypted.mode = "0600";
      };
    };
    system.secrets = {
      "factorio-token".encrypted.file = ./factorio-token.age;
    };
  };
}
