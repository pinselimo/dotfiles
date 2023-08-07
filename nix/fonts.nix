{ config, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      inter
      noto-fonts
      hack-font
      noto-fonts-emoji
      roboto
      (nerdfonts.override { fonts = [ "Noto"
                                      "Hack"
                                    #  "JetBrainsMono"
                                    ]; })
      liberation_ttf
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Noto Sans Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };
}
