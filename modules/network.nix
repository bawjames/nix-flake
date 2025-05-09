{ config, host, ... }:
{
  networking = {
    useDHCP = true;

    hostName = host;

    firewall.enable = false;

    wireless = {
      enable = true;
      networks = {
      };
    };
  };
}
