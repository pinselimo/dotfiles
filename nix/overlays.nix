{ config, pkgs, lib, pinselimo-waybar, expiry-done, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      fishPlugins.done = prev.fishPlugins.done.overrideAttrs (old: {
        version = "1.16.6";
        src = expiry-done;
      });
      fishPlugins.forgit = prev.fishPlugins.forgit;
      fishPlugins.foreign-env = prev.fishPlugins.foreign-env;
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
