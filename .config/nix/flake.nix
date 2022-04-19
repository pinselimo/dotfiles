{
  description = "Pinselimo's flake based system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    #nixpkgs-unstable.url =  "nixpkgs/nixos-unstable";

    vim-monkey-c = {
      flake = false;
      url = "path:/home/pinselimo/vim/vim-monkey-c";
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
