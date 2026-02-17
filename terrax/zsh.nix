{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    initContent = ''
      if [ -f /run/secrets/anthropic_api_key ]; then
        export ANTHROPIC_API_KEY=$(cat /run/secrets/anthropic_api_key)
      fi
      if [ -f /run/secrets/openrouter_api_key ]; then
        export OPENROUTER_API_KEY=$(cat /run/secrets/openrouter_api_key)
      fi
    '';
  };
}
