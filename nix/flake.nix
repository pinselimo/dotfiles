{
  description = "Pinselimo's flake based system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs-stable.url =  "nixpkgs/nixos-22.05";

    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    #neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.7.0?dir=contrib";

    vim-monkey-c = {
      flake = false;
      url = "path:/home/pinselimo/vim/vim-monkey-c";
    };

    pinselimo-waybar = {
      flake = false;
      url = "github:pinselimo/Waybar?rev=da174612c5364528ce305c32e1b6c6be4c7ed6bf";
    };
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.pinkthad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
    nixosConfigurations.bootable = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./iso.nix ];
    };
  };
}
