{
  description = "Pinselimo's flake based system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    #nixpkgs-unstable.url =  "nixpkgs/nixos-unstable";

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
  };
}
