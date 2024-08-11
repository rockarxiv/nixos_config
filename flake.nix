{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    envycontrol.url = "github:bayasdev/envycontrol";
  };

  outputs = { self, nixpkgs, envycontrol, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        { _module.args = inputs; }
        ./configuration.nix
      ];
    };
  };
}
