{ inputs, ... }:
let
  inherit (inputs) microvm home-manager;
in
{
  microvm.vms.terrax = {
    autostart = false;
    specialArgs = {
      inherit inputs;
      hostname = "terrax";
    };
    config = {
      imports = [
        microvm.nixosModules.microvm
        home-manager.nixosModules.home-manager
        ./terrax
      ];
    };
  };
}
