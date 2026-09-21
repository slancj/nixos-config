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

      # Firefox (upstream tarball, e.g. Aph build/firefox) dlopens
      # libavcodec by hardcoded soname. nixpkgs pins the ffmpeg major per
      # Firefox version (wrapper.nix): >=153.1 -> ffmpeg_9 (libavcodec.so.63),
      # else ffmpeg_8 (libavcodec.so.62). Aph currently pins FF 156, so
      # ffmpeg_9 is required; without it H264/AAC fail with
      # NS_ERROR_DOM_MEDIA_METADATA_ERR / "Decode metadata failed".
      # Keep this in sync when Aph's scripts/fetch.py VERSION bumps past
      # the next ffmpeg ABI.
      ffmpeg_9
      libva
      libvdpau
      pipewire
      libgbm
      vulkan-loader
      cups
      libnotify

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
