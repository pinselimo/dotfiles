{ config, pkgs, lora, ... }: {
  environment = {
    systemPackages = let
      defaultPythonPackages = pythonPackages: with pythonPackages; [
        numpy
        matplotlib
        pandas
        ipython
        seaborn
        jupyter
        autopep8

        yq # like jq but for xml
      ];
      defaultHaskellPackages = haskellPackages: with haskellPackages; [
        haskell-language-server
        hoogle
      ];
      latex = with pkgs; texlive.combine {
                inherit (texlive)
                  scheme-small

                  # additional latex libraries
                  amsmath

                  # build tools
                  latexmk
                  ;
                };
    in
    [ lora.packages.x86_64-linux.default ] ++
    (with pkgs; [
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
      delta

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
      latex

      # graphical UI basics
      firefox-esr-wayland
      libwacom
      polkit_gnome
      gnome.adwaita-icon-theme
      xdg-utils
      imv
      pulseaudio
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
      ncspot
      #cava
      pidgin
      zotero
      libreoffice
      inkscape
      xournalpp
      calibre
      zathura
      vlc
      chromium
      signal-desktop
      #falsisign
      jq # for fishPlugins.done
    ]) ++ (with pkgs.fishPlugins; [
      done
      forgit
      #pisces
    ]);

    pathsToLink = [ "/libexec" "/share/nix-direnv" ];
    variables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";

      # Java
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

      # done
      __done_sway_ignore_visible = "1";
      __done_notify_sound = "0";
      __done_min_cmd_duration = "1000";
      __done_expire_time = "3000";
    };
  };
}
