{ config, pkgs, glasa, lora, nixpkgs-stable, my-golden-cheetah, ... }: {
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
        sympy
        scipy

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
    [ glasa.packages.x86_64-linux.default ] ++
    [ nixpkgs-stable.legacyPackages.x86_64-linux.libreoffice-fresh ] ++
    [ my-golden-cheetah.packages.x86_64-linux.default ] ++
    (with pkgs; [
      # terminal basics
      locale
      fish
      bash
      foot
      killall
      wget
      gitFull
      libsixel

      # Modern Unix
      eza
      bat
      duf
      ripgrep
      gtop
      gping
      procs
      xh # httpie
      thefuck
      delta
      unzip

      # flakey nix-shell replacement
      direnv
      nix-direnv

      # pl basics
      (python310.withPackages defaultPythonPackages)
      (ghc.withPackages defaultHaskellPackages)
      cabal-install
      idris2
      rlwrap
      (agda.withPackages (p: [ p.standard-library ]))
      emacs
      nodejs # for CoC
      coq
      coqPackages.coqide
      netlogo
      latex
      libnfc

      # graphical UI basics
      firefox-esr
      #libwacom
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
      glib
      gnome.gnome-tweaks
      gnomeExtensions.pano  # clipboard manager
      #gnomeExtensions.glasa # eyes - uses local version, see above
      gnomeExtensions.snowy # snow
      gnomeExtensions.focus # transparent unfocused windows
      gnomeExtensions.openweather # open weather pane
      gnomeExtensions.pixel-saver # hides top bars
      gnomeExtensions.user-themes # customizable themes
      gnomeExtensions.another-window-session-manager # reopen sessions
      wmctrl # switch workspaces

      # GNOME apps
      authenticator
      apostrophe
      blanket
      bottles
      dialect
      gnome-obfuscate
      plots
      gnome-secrets
      shortwave
      gnome-solanum
      tangram

      # apps
      gaphor
      zettlr
      pavucontrol
      gnome.seahorse
      networkmanagerapplet
      krita-beta
      ncspot
      spotify
      pidgin
      zotero_7
      inkscape
      xournalpp
      calibre
      zathura
      vlc
      chromium
      signal-desktop
      jq # for fishPlugins.done
      jmtpfs
      wireshark
      planify
      protonup-ng
      protontricks
    ]) ++ (with pkgs.fishPlugins; [
      done
      forgit
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
