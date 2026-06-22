{
  description = "ashtonaut-laptop NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { 
    nixpkgs, 
    home-manager, 
    disko, 
    ... 
  }@inputs: {
    nixosConfigurations.ashtonaut-laptop = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.ashtonaut = ./home.nix;
          };
        }
        disko.nixosModules.disko
      ];
    };
  };
}
