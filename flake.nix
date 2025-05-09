{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    impermanence.url = "github:nix-community/impermanence";

    sops-nix.url = "github:Mic92/sops-nix";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... } @ inputs:
  with inputs; let
    globals = {
      user = "james";
      host = "redguard";

      disks = ["/dev/nvme0n1" "/dev/nvme1n1"];
    };
  in {
    nixosConfigurations.${globals.host} = nixpkgs.lib.nixosSystem {
      specialArgs = globals;

      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager
        
        ({ lib, user, ... }: {
          imports = [
            (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" user ])
          ];
        })

        nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        disko.nixosModules.disko

        ./modules

        ({ user, ... }: { # move this somewhere else
          hm.home = {
            username = user;
            homeDirectory = "/home/${user}";
            packages = with pkgs; [
              lazygit
              dysk
            ];
            stateVersion = "24.11";
          };

          nixpkgs.config.allowUnfree = true;
          system.stateVersion = "24.11";
        })
      ];
    };
  };
}
