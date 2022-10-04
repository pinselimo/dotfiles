{
  description = "Pinselimo's flake based system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url =  "nixpkgs/nixos-22.05";

    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    #neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.7.0?dir=contrib";

    vim-monkey-c = {
      flake = false;
      url = "path:/home/pinselimo/vim/vim-monkey-c";
    };

    expiry-done = {
      flake = false;
      url = "github:huafu/done?rev=78b812b2cb14ab8f0dc5ea3f3b4939c8b84e392f";
    };

    pinselimo-waybar = {
      flake = false;
      url = "github:pinselimo/Waybar?rev=61886b3b99e09fc2718b1866231fc4943b7d6e14";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@attrs: rec {
    nixosConfigurations.pinkthad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };

    # Bootable ISOs
    nixosConfigurations.bootable = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        ./bootable.nix
      ];
    };
    nixosConfigurations.raspberry = nixpkgs-stable.lib.nixosSystem {
      system = "armv7l-linux";
      specialArgs = attrs;
      modules = [
        "${nixpkgs-stable}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
        ./raspberry.nix
      ];
    };
    images.bootable = nixosConfigurations.bootable.config.system.build.iso;
    images.raspberry = nixosConfigurations.raspberry.config.system.build.sdImage;
  };
}
