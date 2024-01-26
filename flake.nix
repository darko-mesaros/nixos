{
  description = "Darko Mesaros"; #  

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

  };

  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; ## from https://thiscute.world/en/posts/nixos-and-flake-basics/
    nh = {  ## https://github.com/viperML/nh
      url = "github:viperML/nh";
      # inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot ## disabled because: https://github.com/viperML/nh/issues/33#issuecomment-1719833405
    };
  };

  outputs = inputs@{
    self,
      nixpkgs,
      nix,
      nixos-hardware,
      home-manager,
      ...
  }: {
    nixosConfigurations = {
      
      default = nixpkgs.lib.nixosSystem {
        ## The NixOS VM used on the Live Stream
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "23.11"; # Did you read the comment?

	        }
          ./hosts/opsworks
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                 inherit inputs; # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                 inherit (config.networking) hostName;
            };
            home-manager.users.darko = {...}: { 
                      imports = [
                          ./homemanager.nix
			  ./homemanager/cli-tools.nix
                          #./homemanager/qemu-kvm-guest.nix
                      ];
                 };
          }) # end home-manager
        ]; # end modules
      }; # end nixos-VM

      nixdev = nixpkgs.lib.nixosSystem {
        ## The NixOS VM used on the Live Stream
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "23.11"; # Did you read the comment?

	        }
          ./hosts/nixdev
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                 inherit inputs; # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                 inherit (config.networking) hostName;
            };
            home-manager.users.darko = {...}: { 
                      imports = [
                          ./homemanager.nix
			  ./homemanager/cli-tools.nix
			  ./homemanager/dotfiles.nix
                          #./homemanager/qemu-kvm-guest.nix
                      ];
                 };
          }) # end home-manager
        ]; # end modules
      }; # end NIXDEV

    };
  };
}
