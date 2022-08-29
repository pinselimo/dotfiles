{ config, pkgs, ... }:
{
  boot = {
    initrd.verbose = false;
    plymouth.enable = true;
    loader.grub = {
      enable = true;
      version = 2;
      extraGrubInstallArgs = [ "--modules=all_video" ];
      # Define on which hard drive you want to install Grub.
      device = "/dev/nvme0n1"; # or "nodev" for efi only
      extraEntries = ''
        menuentry "Windows 10" {
          chainloader (hd0,1)+1
        }
      '';
    };
  };

  networking = {
    hostName = "pinkthad"; # Define your hostname.
    #nameservers = [ "1.1.1.1" "9.9.9.9" ];
    wireless.enable = false;  # Enables wireless support via wpa_supplicant. I use networkmanager instead.
    networkmanager = {
      enable = true;
      #dns = "none";
      #ethernet.macAddress = "random";
      #wifi = {
        #backend = "iwd";
        #macAddress = "random";
      #};
      plugins = [ pkgs.networkmanager-openvpn ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp2s0.useDHCP = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_ADDRESS = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "de";
    useXkbConfig = true;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    opengl.enable = true;
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
