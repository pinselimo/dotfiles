{ config, pkgs, lib, wifi-key, ... }:
{
  imports =
    [
      ./nix.nix
    ];

  nixpkgs = {
    config.allowUnsupportedSystem = true;
    crossSystem.system = "armv7l-linux";
    localSystem.system = "x86_64-linux";
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };

  nix.settings = {
    # previously: nix.binaryCaches
    substituters = lib.mkForce [ "https://cache.armv7l.xyz" ];
    # previously: nix.binaryCachePublicKeys
    trusted-public-keys = [
      "cache.armv7l.xyz-1:kBY/eGnBAYiqYfg0fy0inWhshUo+pGFM3Pj7kIkmlBk="
    ];
  };

  # Instead of hardware-configuration.nix
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  boot = {
    # For raspi serial console
    kernelParams = [
      "console=ttyS1,115200n8"
    ];

    loader = {
      grub.enable = false;
      raspberryPi = {
        version = 2;
        uboot = {
          enable = true;
          configurationLimit = 2;
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

