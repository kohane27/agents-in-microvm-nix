{ ... }:
{
  systemd.services.copy-claude-json = {
    description = "Copy .claude.json to microVM user home";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      if [ -f /home/microvm/.claude/microvm/.claude.json ]; then
        cp /home/microvm/.claude/microvm/.claude.json /home/microvm/.claude.json
      fi
    '';
  };
}
