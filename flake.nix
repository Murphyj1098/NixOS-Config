{
  description = "jrmurphy NixOS & Home Manager Configuration";

  outputs = {self, nixpkgs, home-manager, ... }:
    let
      # ----- System Settings ----- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "scopuli";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
      };
      
      # ----- User Settings ----- #
      userSettings = rec {
        username = "jrmurphy";
        name = "Joseph Murphy";
        wm = "hyprland";
        browser = "firefox";
        term = "kitty";
        font = "MesloLGS NF";
        fontPkg = pkgs.meslo-lgs-nf;
        editor = "nano";
      };

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      lib = nixpkgs.lib;

    in {
    
      homeConfigurations = {
        jrmurphy = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      nixosConfigurations = {
        scopuli = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
      
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

}
