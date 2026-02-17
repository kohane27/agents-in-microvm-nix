{ ... }:
{
  security.doas.extraRules = [
    {
      users = [ "username" ];
      noPass = true;
      keepEnv = true;
      cmd = "systemctl";
      args = [
        "start"
        "microvm@terrax.service"
      ];
    }
    {
      users = [ "username" ];
      noPass = true;
      keepEnv = true;
      cmd = "systemctl";
      args = [
        "stop"
        "microvm@terrax.service"
      ];
    }
    {
      users = [ "username" ];
      noPass = true;
      keepEnv = true;
      cmd = "systemctl";
      args = [
        "restart"
        "microvm@terrax.service"
      ];
    }
    {
      users = [ "username" ];
      noPass = true;
      keepEnv = true;
      cmd = "umount";
    }
    {
      users = [ "username" ];
      noPass = true;
      keepEnv = true;
      cmd = "mount";
    }
  ];
}
