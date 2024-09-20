{
  description = "Kemalmao minimal flake for Darwin";
  inputs = {
    # called derivations that say how to build software.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable"; # unstable channel 
    };

    # Manages configs links things into your home directory
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix darwin  
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations.kemalmao = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config = { allowUnfree = true; };
      };

      modules = [
        ./modules/darwin

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.kemal.imports = [ ./modules/home-manager ];
          };
          users.users.kemal.home = "/Users/kemal";
        }
      ];
    };
  };
}
