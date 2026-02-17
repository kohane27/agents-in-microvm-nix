{ pkgs, ... }:
{
  users.groups.microvm.gid = 1000;
  users.users.microvm = {
    isNormalUser = true;
    uid = 1000;
    group = "microvm";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 *** username@snowfire"
    ];
  };
}
