{ config, pkgs, lib, pinselimo-waybar, expiry-done, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      done = prev.done.overrideAttrs (old:
        { src = expiry-done; });
    })

    (final: prev: {
      nix-direnv = prev.nix-direnv.override
        { enableFlakes = true; };
    })

    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old : {
        version = "0.9.13";
        src = pinselimo-waybar;
        buildInputs = [ pkgs.libevdev pkgs.libxkbcommon pkgs.catch2 pkgs.upower pkgs.jack2 ] ++ prev.waybar.buildInputs ;
      });
    })
  ];
}
