{ config, ... }:

{
  home.persistence."/persist" = {
    directories = [
      ".local/share/atuin"
      ".local/share/containers"
      ".local/share/distrobox"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".ssh"
      "Safe"
      ".var/app/app.zen_browser.zen"
      ".config/zen"
      ".local/share/Trash"
      ".librewolf/custom"
      ".local/share/Steam"
      ".config/aph"
      ".config/gh"
      ".local/share/Anki2"
      ".local/share/AnkiProgramFiles"
    ];
    files = [
      ".local/bin/aph"
      ".local/share/applications/aph.desktop"
      ".local/share/icons/hicolor/128x128/apps/aph.png"
    ];
  };
}
