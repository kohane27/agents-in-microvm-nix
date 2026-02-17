{ config, ... }:
{
  sops.secrets = {
    terrax-anthropic-api-key = {
      sopsFile = ../../../hosts/shared/ai.yaml;
      key = "ANTHROPIC_API_KEY";
    };
    terrax-openrouter-api-key = {
      sopsFile = ../../../hosts/shared/ai.yaml;
      key = "OPENROUTER_API_KEY";
    };
  };

  systemd.services.terrax-prepare-secrets = {
    description = "Stage secrets for terrax MicroVM";
    wantedBy = [ "microvm@terrax.service" ];
    before = [ "microvm@terrax.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      dir=/var/lib/microvms/terrax/secrets
      mkdir -p "$dir"
      install -m 0444 ${config.sops.secrets.terrax-anthropic-api-key.path} "$dir"/anthropic_api_key
      install -m 0444 ${config.sops.secrets.terrax-openrouter-api-key.path} "$dir"/openrouter_api_key
    '';
  };
}
