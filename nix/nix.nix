{ config, pkgs, ... }:
{
  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      '';
  };
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      #pidgin = pkgs.pidgin.override {
        ### Add whatever plugins are desired (see nixos.org package listing).
        #plugins = [ pidgin-sipe ];
      #};
    };
  };
}
