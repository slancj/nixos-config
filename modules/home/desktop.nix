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
    "text/html"
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

  associate = app: mimes: lib.genAttrs mimes (name: [ app ]);
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
    calibre qview anki vlc localsend
    libsecret seahorse dolphin-emu eden
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      (associate "com.interversehq.qView.desktop" imageMimes) //
      (associate "codium.desktop" textMimes);
  };

  programs.mpv = {
    enable = true;
  };

  programs.yt-dlp = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
    extraOptions = [
      "--home=/home/trueking/Safe/Obsidian Vault/.configsync"
    ];
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

  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/persist/etc/nixos/dotfiles/waybar/velvet";
  xdg.configFile."hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink "/persist/etc/nixos/dotfiles/hypr/hyprland.lua";
  xdg.configFile."Kvantum/kvantum.kvconfig".enable = false;
}
