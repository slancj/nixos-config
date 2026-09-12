{ config, ... }:

{
  home.persistence."/persist" = {
    directories = [
      ".local/share/containers"
      ".local/share/distrobox"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".ssh"
      "Safe"
      ".var/app"
      ".config/zen"
      ".local/share/Trash"
      ".config/mozilla/firefox/persistent"
      ".librewolf/custom"
      ".local/share/Steam"
      ".config/aph"
    ];
    files = [
      ".local/bin/aph"
    ];
  };
}
