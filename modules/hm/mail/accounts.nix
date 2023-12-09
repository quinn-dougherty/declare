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
      # gmail = {
      #   address = "quinn.dougherty92@gmail.com";
      #   userName = "quinn.dougherty92@gmail.com";
      #   passwordCommand =
      #     "age -d -i ~/.ssh/id_qd_ed25519 ${secrets.qd92-gmail-pass.encrypted.file}";
      #   imap.host = "imap.gmail.com";
      #   mu.enable = true;
      #   mbsync = {
      #     enable = true;
      #     create = "imap";
      #   };
      # };
    };
  };
}
