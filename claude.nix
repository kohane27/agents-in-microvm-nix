{ ... }:
{
  systemd.services.terrax-prepare-claude-config = {
    description = "Stage Claude config for terrax MicroVM";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "username";
    };
    script = ''
      mkdir -p $HOME/.claude/microvm
      cp $HOME/.claude.json $HOME/.claude/microvm/
    '';
  };
}
