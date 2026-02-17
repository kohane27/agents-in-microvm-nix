{ ... }:
{
  services.resolved.enable = true;
  systemd = {
    network = {
      enable = true;
      networks."10-e" = {
        matchConfig.Name = "e*";
        addresses = [ { Address = "192.168.83.6/24"; } ];
        routes = [ { Gateway = "192.168.83.1"; } ];
      };
    };
    settings.Manager = {
      DefaultTimeoutStopSec = "5s";
    };
    mounts = [
      {
        what = "store";
        where = "/nix/store";
        overrideStrategy = "asDropin";
        unitConfig.DefaultDependencies = false;
      }
    ];
  };
}
