{
  description = "Pinselimo's flake based system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url =  "nixpkgs/nixos-23.11";

    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    #neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.7.0?dir=contrib";

    vim-monkey-c = {
      flake = false;
      url = "path:/home/pinselimo/vim/vim-monkey-c";
    };

    lora.url = "github:pinselimo/lora/main";
    #idris2-latest.url = "path:/home/pinselimo/Idris/Idris2";
    glasa.url = "github:pinselimo/gnome-extension-glasa/cross-eye-45-nix";

    # This is necessary until networkmanager-openconnect version 1.2.9
    #oc-sso.url = "path:/home/pinselimo/Python/openconnect-sso";

    my-golden-cheetah = {
      #flake = false;
      url = "path:/home/pinselimo/CPP/GoldenCheetah";
    };

    expiry-done = {
      flake = false;
      url = "path:/home/pinselimo/shell/done";
    };

    #waybar-latest.url = "github:Alexays/Waybar/master";
  };

  outputs = { self, nixpkgs, ... }@attrs: rec {
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
