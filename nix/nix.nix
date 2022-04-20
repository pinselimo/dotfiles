{ config, pkgs, ... }:
{
  nix = {
    autoOptimiseStore = true;
    package = pkgs.nix_2_7;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      '';
  };
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
        ## Add whatever plugins are desired (see nixos.org package listing).
        plugins = [ pidgin-sipe ];
      };
    };
  };
}
