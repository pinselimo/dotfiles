{ config, pkgs, ... }:
{
  security.pam.services.login = {
    enableGnomeKeyring = true;
    fprintAuth = true;
  };

  # For screen sharing
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
  };

  services = {
    # fprintd.enable = true;

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };

    xserver = {
      # Configure keymap in X11
      layout = "de";
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
