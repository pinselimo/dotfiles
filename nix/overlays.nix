{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    # LISGD
    #(final: prev: {
      #lisgd = prev.lisgd.overrideAttrs (old : {
        ##version = "0.3.2";
        #src = /home/pinselimo/C/lisgd;
        #buildInputs = prev.lisgd.buildInputs ++ [ pkgs.xorg.libX11 ];
        #nativeBuildInputs = [ pkgs.xorg.libX11 ];
      #});
    #})
    (final: prev: {
      nix-direnv = prev.nix-direnv.override 
        { enableFlakes = true; }; 
    })

    ## WAYBAR
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old : {
        version = "0.9.12";
        src = pkgs.fetchFromGitHub {
          owner = "pinselimo";
          repo = "Waybar";
          rev = "da174612c5364528ce305c32e1b6c6be4c7ed6bf";
          sha256 = "1ahasnfgi2ljz5nqd27fnd4g8fzi4mqb9m26d6ik2ib1lnd8xbgh";
        };
        buildInputs = [ pkgs.libevdev pkgs.libxkbcommon pkgs.catch2 pkgs.upower ] ++ prev.waybar.buildInputs ;
      });
    })

    # wlroots
    #(final: prev: {
      #wlroots = prev.wlroots.overrideAttrs (old : {
        #version = "0.15.0";
        #src = pkgs.fetchFromGitHub {
          #owner = "swaywm";
          #repo = "wlroots";
          #rev = "0467a7523ae79abd454b1fa9e7161d54d3c6f069";
          #sha256 = "0qsxh93zxxjb0bs95j41qhk0k2y2gq1dv5c5vsg09gy4y0n6qpky";
        #};
        #buildInputs = prev.wlroots.buildInputs ++ [ pkgs.libseat ];
      #});
    #})

    # sway
    #(final: prev: {
      #sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old : {
        #version = "1.6";
        #src = /home/pinselimo/C/sway ;
      #});
    #})

    # SWAYLOCK
   #(final: prev: {
      #swaylock-effects = prev.swaylock-effects.overrideAttrs (old : {
        #src = /home/pinselimo/C/swaylock-effects ;
      #});
    #})
  ];
}
