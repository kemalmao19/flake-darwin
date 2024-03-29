{
  description = "Kemalmao minimal flake for Darwin";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11
    };

    # Manages configs links things into your home directory
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Controls system level software and settings including fonts
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kemalmao-nixvim = {
      url = "github:kemalmao19/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = inputs@{ nixpkgs, home-manager, darwin, kemalmao-nixvim, ... }: {
    darwinConfigurations.kemalmao = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config = {
          allowUnfree = true;
          # allowUnsupportedSystem = true;
          # allowBroken = true;
        };

        #overlays = [
        # (final: prev: {
        #   neovim = kemalmao-nixvim.packages.system.default;
        # })
        #];
      };

      modules = [
        ./modules/darwin

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.kemalmao.imports = [
              ./modules/home-manager
            ];
          };
        }
      ];
    };
  };
}
