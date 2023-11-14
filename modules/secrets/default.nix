let
  herc = {
    secrix.services.hercules-ci-agent.secrets = {
      "binary-caches.json" = {
        encrypted.file = ./binary-caches.json.age;
        decrypted.builder = ''
          mkdir -p /var/lib/hercules-ci-agent/secrets
          ln -s $inFile /var/lib/hercules-ci-agent/secrets/binary-caches.json
        '';
      };
      "secrets.json" = {
        encrypted.file = ./secrets.json.age;
        decrypted.builder = ''
          mkdir -p /var/lib/hercules-ci-agent/secrets
          ln -s $inFile /var/lib/hercules-ci-agent/secrets/secrets.json
        '';
      };
      "cluster-join-token.key" = {
        encrypted.file = ./cluster-join-token.key.age;
        decrypted.builder = ''
          mkdir -p /var/lib/hercules-ci-agent/secrets
          ln -s $inFile /var/lib/hercules-ci-agent/secrets/cluster-join-token.key
        '';
      };
    };
  };
in
herc
