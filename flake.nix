{
  description = "jrmurphy NixOS & Home Manager Configuration";

  outputs = inputs@{self, nixpkgs, home-manager, stylix, ... }:
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
        font = "JetBrains Mono";
        fontPkg = pkgs.jetbrains-mono;
        editor = "nano";
        theme = "dracula";
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
            inherit (inputs) stylix;
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
            inherit (inputs) stylix;
          };
        };
      };
      
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-23.11";
  };

}
