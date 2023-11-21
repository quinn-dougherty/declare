{
  secrix.services = {
    hercules-ci-agent.secrets = {
      "binary-caches.json".encrypted.file = ./binary-caches.json.age;
      "secrets.json".encrypted.file = ./secrets.json.age;
      "cluster-join-token.key".encrypted.file = ./cluster-join-token.key.age;
    };
    nextcloud.secrets = {
      "nextcloud-db-pass".encrypted.file = ./nextcloud-db-pass.age;
    };
    nix-serve.secrets = {
      "cache-priv-key.pem".encrypted.file = ./cache-priv-key.pem;
    };
  };
}
