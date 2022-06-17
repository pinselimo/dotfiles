{ config, pkgs, lib, pinselimo-waybar, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      nix-direnv = prev.nix-direnv.override 
        { enableFlakes = true; }; 
    })

    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old : {
        version = "0.9.12";
        src = pinselimo-waybar;
        buildInputs = [ pkgs.libevdev pkgs.libxkbcommon pkgs.catch2 pkgs.upower ] ++ prev.waybar.buildInputs ;
      });
    })
  ];
}
