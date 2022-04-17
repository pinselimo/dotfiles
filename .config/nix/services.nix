{ config, pkgs, ... }:
{
  security.pam.services.login = {
    enableGnomeKeyring = true;
    fprintAuth = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
  };

  # List services that you want to enable:
  services = {
    fprintd.enable = true;

    xserver = {
      # Configure keymap in X11
      layout = "de";
      # services.xserver.xkbOptions = "eurosign:e";
      wacom.enable = true;
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    blueman.enable = true;
    pipewire = {
      enable = true;
      # alsa.enable = true;
      # alsa.support32Bit = true;
      # jack.enable = true;
      # pulse.enable = true;
      socketActivation = true;
    };
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    gnome.gnome-keyring.enable = true;

    flatpak.enable = true; # for the usual corporate shit like zoom-us, ms-teams etc.
  };
}
