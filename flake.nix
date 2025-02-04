{
  description = "Darwin system flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs?rev=d2faa1bbca1b1e4962ce7373c5b0879e5b12cef2";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      user = "harry";
      homeDir = "/Users/${user}";
      system = "aarch64-darwin";
      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        nix.optimise.automatic = true;

        # Nix configuration
        nix.settings = {
          builders-use-substitutes = true;
          experimental-features = [ "nix-command" "flakes" ];
          substituters = [ "https://nix-community.cachix.org" ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
          trusted-users = [ "${user}" ];
          warn-dirty = false;
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "${system}";

        users.users.${user}.home = "${homeDir}";

        homebrew = {
          enable = true;

          casks = [
            "docker"
            "raycast"
          ];
        };

        fonts = {
          packages = with pkgs; [
            jetbrains-mono
          ];
        };
      };
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#HV-MBP
      darwinConfigurations."HV-MBP" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.harry = import ./modules/home-manager.nix {
              inherit inputs pkgs homeDir;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."HV-MBP".pkgs;
    };
}
