{ config, pkgs, lib, ... }:

let
  commonContainers = import ./browser-containers.nix;

  sharedSettings = {
    "browser.cache.memory.capacity" = 1048576;
    "browser.cache.memory.max_entry_size" = 51200;
    "network.http.max-connections" = 1800;
  };

  customSettings = sharedSettings // {
    "sidebar.verticalTabs" = true;
  };
in
{
  programs.librewolf = {
    enable = true;

    profiles = {
      # 1. Stock profile: untouched vanilla LibreWolf.
      stock = {
        id = 0;
        name = "stock";
        isDefault = true;
      };

      # 2. Custom profile: fully configured daily driver.
      custom = {
        id = 1;
        name = "custom";
        isDefault = false;

        settings = customSettings;

        bookmarks = { force = true; settings = import ../../bookmarks.nix; };
        containersForce = true;
        containers = commonContainers;
      };
    };
  };
}