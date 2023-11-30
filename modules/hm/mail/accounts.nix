{ laptop, inputs, secrets, config, lib, pkgs, ... }:

{
  accounts.email = {
    maildirBasePath = "/home/${laptop.username}/.mail";
    accounts = {
      riseup = {
        address = "quinnd@riseup.net";
        userName = "quinnd@riseup.net";
        primary = true;
        passwordCommand =
          "age -d -i ~/.ssh/id_qd_ed25519 ${secrets.quinnd-riseup-pass.encrypted.file}";
        imap.host = "mail.riseup.net";
        mu.enable = true;
        mbsync = {
          enable = true;
          create = "imap";
        };
      };
    };
  };
}
