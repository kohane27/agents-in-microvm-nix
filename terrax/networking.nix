{ ... }:
{
  networking = {
    useDHCP = false;
    useNetworkd = true;
    tempAddresses = "disabled";
    firewall.enable = false;
  };

  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];
}
