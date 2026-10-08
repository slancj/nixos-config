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
      # Both flatpak installs share app ID org.mozilla.firefox (stable on
      # system/flathub, beta on user/flathub-beta) and export the same
      # org.mozilla.firefox.desktop filename. The user export shadows the
      # system one, so without overrides every Firefox launcher starts beta.
      # Fix: pin the generic entry to system/stable via this override file,
      # and pin org.mozilla.firefox-beta.desktop to user/beta (--user).
      ".local/share/applications/org.mozilla.firefox.desktop"
      ".local/share/applications/org.mozilla.firefox-beta.desktop"
      ".local/share/icons/hicolor/128x128/apps/aph.png"
    ];
  };
}
