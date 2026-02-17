{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      hostname = "terrax";
      isDarwin = false;
    };
    users.microvm = {
      imports = [
        ./zsh.nix
      ];
      home = {
        username = "microvm";
        homeDirectory = "/home/microvm";
        stateVersion = "25.11";
        sessionVariables = {
          EDITOR = "vim";
          VISUAL = "vim";
        };
      };
      programs.home-manager.enable = true;
    };
  };
}
