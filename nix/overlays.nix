{ config, pkgs, lib, expiry-done, ... }:
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
  ];
}
