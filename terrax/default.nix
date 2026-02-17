{ pkgs, inputs, ... }:
let
  llm = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./microvm.nix
    ./user.nix
    ./sshd.nix
    ./nix.nix
    ./systemd.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./home-manager.nix
    ./claude.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    zsh
    wget
    curl
    vim
    tmux
    which
    jq
    fzf
    ripgrep
    gnugrep
    gawkInteractive
    ps
    findutils
    moreutils
    diffutils
    bc
    killall
    direnv
    libnotify

    llm.claude-code
    llm.opencode
    llm.openspec
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  networking.hostName = "terrax";
  system.stateVersion = "25.11";
}
