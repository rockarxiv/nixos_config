{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    envycontrol.url = "github:bayasdev/envycontrol";
  };

  outputs = { self, nixpkgs, envycontrol, ... }@inputs: {
    # Please replace my-nixos with your hostname
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
