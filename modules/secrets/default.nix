let
  herc = {
    secrix.services.hercules-ci-agent.secrets = {
      "binary-caches.json".encrypted.file = ./binary-caches.json.age;
      "secrets.json".encrypted.file = ./secrets.json.age;
      "cluster-join-token.key".encrypted.file = ./cluster-join-token.key.age;
    };
  };
in
herc
