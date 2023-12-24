{ config, pkgs, ... }:
{
  hardware.pulseaudio.enable = false;

  security = {
    pam.services.login = {
      enableGnomeKeyring = true;
      # fprintAuth = true;
    };
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "pinselimo" ];
        keepEnv = true;
      }];
    };
    rtkit.enable = true; # for PipeWire
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
    fwupd.enable = true;
    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="5147", ATTR{authorized}="0"
    '';
    udisks2.enable = true;
    greetd = {
      enable = false;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };

    xserver = {
      enable = true;
      # Configure keymap in X11
      layout = "de";
      wacom.enable = false;
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      # Enable GNOME
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    gnome.at-spi2-core.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [ hplip hplipWithPlugin ];
    };
    avahi = {
      enable = true;
      openFirewall = true;
    };

    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      socketActivation = true;
    };
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    gnome.gnome-keyring.enable = true;

    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        sources.relays = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
            "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/relays.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
        server_names = [ "cloudflare-ipv6" "cloudflare" "google-ipv6" "google" ];
      };
    };

    flatpak.enable = true; # for the usual corporate shit like zoom-us, ms-teams etc.
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
