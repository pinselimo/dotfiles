{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in {
  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = let
      defaultPythonPackages = pythonPackages: with pythonPackages; [
        numpy
        matplotlib
        pandas
        seaborn
        ipython
        jupyter
        jupyterlab
        autopep8
      ];
      defaultHaskellPackages = haskellPackages: with haskellPackages; [
        haskell-language-server
      ];
    in with pkgs; [
      locale
      fish
      bash
      foot
      killall
      thefuck
      wget
      firefox-esr-wayland
      gitFull
      wl-clipboard
      polkit_gnome
      gnome3.adwaita-icon-theme
      xdg-utils
      imv
      #unstable.obs-studio
      #unstable.obs-studio-plugins.wlrobs
      krita-beta
      libwacom
      #ncspot
      #cava
      (python39.withPackages defaultPythonPackages)
      pidgin-with-plugins
      (ghc.withPackages defaultHaskellPackages)
      cabal-install
      idris2
      (agda.withPackages (p: [ p.standard-library ]))
      emacs
      rlwrap
      zotero
      libreoffice
      inkscape
      pipewire
      nodejs # for CoC
      xournalpp
      calibre

      # Modern Unix
      exa
      bat
      duf
      ripgrep
      gtop
      gping
      procs
      xh # httpie

      # Nix shell replacement
      direnv
      nix-direnv

      # User
      swaylock-effects
      light
      wl-clipboard
      clipman
      mako
      wofi
      waybar
      pavucontrol
      libnotify
      openconnect
      coq
      netlogo
      gnome.seahorse
      gnome.gnome-keyring
      libsecret
      wl-mirror
    ];

    pathsToLink = [ "/libexec" "/share/nix-dienv" ];
    variables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";

      # Java
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    };
  };
}
