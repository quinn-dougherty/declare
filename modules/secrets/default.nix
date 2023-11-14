let
  herc = {
    secrix.services.hercules-ci-agent.secrets = {
      "binary-caches.json.age" = {
        encrypted.file = ./binary-caches.json.age;
        #decrypted.owner = "root";
        #decrypted.builder = ''
        #  mkdir -p /var/lib/hercules-ci-agent/secrets
        #  chown -R hercules-ci-agent /var/lib/hercules-ci-agent/secrets
        #  rm /var/lib/hercules-ci-agent/binary-caches.json
        #  ln -s $inFile /var/lib/hercules-ci-agent/secrets/binary-caches.json
        #'';
      };
      "secrets.json.age" = {
        encrypted.file = ./secrets.json.age;
        #decrypted.owner = "root";
        #decrypted.builder = ''
        #  mkdir -p /var/lib/hercules-ci-agent/secrets
        #  chown -R hercules-ci-agent /var/lib/hercules-ci-agent/secrets
        #  rm /var/lib/hercules-ci-agent/secrets.json
        #  ln -s $inFile /var/lib/hercules-ci-agent/secrets/secrets.json
        #'';
      };
      "cluster-join-token.key.age" = {
        encrypted.file = ./cluster-join-token.key.age;
        #decrypted.owner = "root";
        #decrypted.builder = ''
        #  mkdir -p /var/lib/hercules-ci-agent/secrets
        #  chown -R hercules-ci-agent /var/lib/hercules-ci-agent/secrets
        #  rm /var/lib/hercules-ci-agent/secrets/cluster-join-token.key
        #  ln -s $inFile /var/lib/hercules-ci-agent/secrets/cluster-join-token.key
        #'';
      };
    };
  };
in
herc
