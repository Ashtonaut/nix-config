{
  description = "ashtonaut-laptop NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.ashtonaut-laptop = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./configuration.nix
      ];
    };
  };
}
