{ config, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      nspr
      atk
      at-spi2-atk
      libdrm
      mesa
      alsa-lib
      libpulseaudio
      dbus
      libxkbcommon
      libx11
      libxcomposite
      libxdamage
      libxext
      libxcb
      libxfixes
      libXcursor
      libXi
      libXrender
      libXtst
      libXScrnSaver
      libxrandr
      libglvnd

      # For Geph
      glib
      gtk3
      pango
      cairo
      gdk-pixbuf
      libsoup_3
      libsecret
    ];
  };
}
