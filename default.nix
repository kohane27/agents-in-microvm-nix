{ ... }:
{
  imports = [
    ./network.nix
    ./secrets.nix
    ./launcher.nix
    # ./doas.nix
    ./microvm.nix
    ./claude.nix
  ];
}
