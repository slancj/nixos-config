{
  description = "Trueking's NixOS Impermanence + Disko System";

  inputs = {
    # Using NixOS unstable for the latest packages and Wayland updates
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management (not integrated yet - input only)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  # --- ADDED home-manager TO OUTPUTS ---
  outputs = { self, nixpkgs, disko, impermanence, home-manager, zen-browser, ... }@inputs: {
    # "latitude" is your hostname. You will use this in the install command.
    nixosConfigurations.latitude = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules =[

        disko.nixosModules.disko
        impermanence.nixosModules.impermanence

        ./hosts/latitude

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.trueking = import ./home.nix;
        }

      ];
    };
  };
}
