{
  config,
  lib,
  pkgs,
  ...
}:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "quinn.dougherty.forall@gmail.com";
  };
}
