{ config, pkgs, lib, ... }:

let
  imageMimes = [
    "image/jpeg"
    "image/png"
    "image/gif"
    "image/webp"
    "image/bmp"
    "image/tiff"
    "image/svg+xml"
    "image/heic"
    "image/x-tga"
  ];

  textMimes = [
    "text/plain"
    "text/markdown"
    "text/css"
    "text/javascript"
    "text/x-python"
    "text/x-shellscript"
    "application/json"
    "application/xml"
    "application/javascript"
    "application/x-yaml"
    "application/toml"
  ];

  webMimes = [
    "text/html"
    "application/xhtml+xml"
    "text/xml"
    "application/vnd.mozilla.xul+xml"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ];

  pdfMimes = [
    "application/pdf"
  ];

  archiveMimes = [
    "application/zip"
    "application/x-zip-compressed"
    "application/gzip"
    "application/x-tar"
    "application/x-bzip"
    "application/x-bzip2"
    "application/x-7z-compressed"
    "application/vnd.rar"
    "application/x-xz"
    "application/zstd"
  ];

  videoMimes = [
    "video/mp4"
    "video/x-matroska"
    "video/webm"
    "video/ogg"
    "video/x-msvideo"
    "video/quicktime"
  ];

  audioMimes = [
    "audio/mpeg"
    "audio/flac"
    "audio/ogg"
    "audio/wav"
    "audio/mp4"
    "audio/x-wav"
  ];

  associate = app: mimes: lib.genAttrs mimes (name: [ app ]);

  writerMimes = [
    "application/vnd.oasis.opendocument.text"
    "application/vnd.oasis.opendocument.text-template"
    "application/msword"
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
    "application/rtf"
  ];

  calcMimes = [
    "application/vnd.oasis.opendocument.spreadsheet"
    "application/vnd.oasis.opendocument.spreadsheet-template"
    "application/vnd.ms-excel"
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
    "text/csv"
  ];

  impressMimes = [
    "application/vnd.oasis.opendocument.presentation"
    "application/vnd.oasis.opendocument.presentation-template"
    "application/vnd.ms-powerpoint"
    "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    "application/vnd.openxmlformats-officedocument.presentationml.template"
    "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
  ];

  drawMimes = [
    "application/vnd.oasis.opendocument.graphics"
    "application/vnd.oasis.opendocument.graphics-template"
  ];
in
{
  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };


  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true; # Suppresses GTK/QT warning messages in Wayland
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons  # <--- Updated
        fcitx5-gtk            # Input support for GTK-based applications
      ];
    };
  };

  home.packages = with pkgs; [
    htop grim slurp libnotify hyprpolkitagent satty
    waybar bluez brightnessctl networkmanagerapplet micro
    ncdu proton-vpn gnome-clocks pavucontrol
    hyprsunset jq nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono wl-clipboard wl-clip-persist
    bat ripgrep ffmpeg tesseract aria2
    trash-cli mission-center chisel obsidian easyeffects opencode
    calibre qview anki vlc localsend rpi-imager
    libsecret seahorse dolphin-emu
    libreoffice-qt hunspell hunspellDicts.en_US
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      (associate "com.interversehq.qView.desktop" imageMimes) //
      (associate "code.desktop" textMimes) //
      (associate "zen-beta.desktop" webMimes) //
      (associate "zen-beta.desktop" pdfMimes) //
      (associate "org.gnome.FileRoller.desktop" archiveMimes) //
      (associate "mpv.desktop" videoMimes) //
      (associate "mpv.desktop" audioMimes) //
      { "inode/directory" = [ "thunar.desktop" ]; } //
      (associate "writer.desktop" writerMimes) //
      (associate "calc.desktop" calcMimes) //
      (associate "impress.desktop" impressMimes) //
      (associate "draw.desktop" drawMimes);
    associations.removed = lib.zipAttrsWith (_: vs: lib.unique (lib.concatLists vs)) [
      (associate "calibre-gui.desktop" (writerMimes ++ pdfMimes ++ [ "text/plain" "text/html" "text/rtf" ]))
      (associate "calibre-ebook-edit.desktop" writerMimes)
      (associate "calibre-ebook-viewer.desktop" pdfMimes)
      (associate "org.prismlauncher.PrismLauncher.desktop" archiveMimes)
      (associate "app.zen_browser.zen.desktop" (webMimes ++ pdfMimes))
    ];
  };

  programs.mpv = {
    enable = true;
  };

  programs.yt-dlp = {
    enable = true;
  };

  services.playerctld.enable = true;
  services.cliphist.enable = true;
  services.awww = {
    enable = true;
  };
  services.swaync.enable = true;
  programs.rofi = {
    enable = true;
    # rofi-wayland has been merged into rofi (2.0.0) in current nixpkgs
    # Option A: Built-in dark theme (1-liner)
    theme = "Arc-Dark"; # Other built-ins: "solarized_alternate", "gruvbox-dark-hard"
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [
        {
          path = "/persist/etc/nixos/wallpapers/wallpaper.jpg";
          blur_passes = 10;
          blur_size = 12;
          brightness = 0.25;
          contrast = 0.8;
          vibrancy = 0;
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%H:%M')\"";
          color = "rgba(205, 214, 244, 1.0)";
          font_size = 110;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %d %B %Y')\"";
          color = "rgba(148, 226, 213, 1.0)";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 30";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          position = "0, 160";
          halign = "center";
          valign = "center";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(205, 214, 244)";
          inner_color = "rgb(30, 30, 46)";
          outer_color = "rgb(137, 180, 250)";
          outline_thickness = 4;
          rounding = 12;
          placeholder_text = "<i>Password...</i>";
          shadow_passes = 2;
        }
      ];
    };
  };

  # Native Home Manager GNOME Keyring service
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 120;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 180;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 210;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/persist/etc/nixos/dotfiles/waybar/velvet";
  xdg.configFile."hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink "/persist/etc/nixos/dotfiles/hypr/hyprland.lua";
  xdg.configFile."Kvantum/kvantum.kvconfig".enable = false;
}
