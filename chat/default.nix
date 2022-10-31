  { lib, chat }:
  chat // {
    operatingsystem = lib.nixosSystem {
      system = chat.system;
      modules = import ./modules.nix { inherit chat; };
    };
  }
