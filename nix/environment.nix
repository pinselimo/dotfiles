{ config, pkgs, ... }: {
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
        hoogle
      ];
    in with pkgs; [
      # terminal basics
      locale
      fish
      bash
      foot
      killall
      wget
      gitFull

      # Modern Unix
      exa
      bat
      duf
      ripgrep
      gtop
      gping
      procs
      xh # httpie
      thefuck

      # flakey nix-shell replacement
      direnv
      nix-direnv

      # pl basics
      (python39.withPackages defaultPythonPackages)
      (ghc.withPackages defaultHaskellPackages)
      cabal-install
      idris2
      rlwrap
      (agda.withPackages (p: [ p.standard-library ]))
      emacs
      nodejs # for CoC
      coq
      netlogo

      # graphical UI basics
      firefox-esr-wayland
      libwacom
      polkit_gnome
      gnome3.adwaita-icon-theme
      xdg-utils
      imv
      pipewire
      swaylock-effects
      light
      clipman
      mako
      libnotify
      openconnect
      gnome.gnome-keyring
      libsecret
      wofi
      waybar
      wl-clipboard
      wl-mirror

      # apps
      pavucontrol
      gnome.seahorse
      krita-beta
      #ncspot
      #cava
      pidgin-with-plugins
      zotero
      libreoffice
      inkscape
      xournalpp
      calibre
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