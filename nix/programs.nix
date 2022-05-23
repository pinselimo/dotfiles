{ config, pkgs, ... }:
{
  programs = {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # mtr.enable = true;
  # gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

    fish.enable = true;
    light.enable = true;
    qt5ct.enable = true;

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        swaybg
        dmenu
        xdg-desktop-portal # screensharing
        xdg-desktop-portal-wlr # screensharing
        squeekboard # virtual keyboard
        lisgd # for touch input
        grim # screenshots
        slurp # screenshots
        avizo
        libinput-gestures
      ];
    };
  };
}
