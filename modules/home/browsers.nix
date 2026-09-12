{ config, pkgs, ... }:

let
  sharedSettings = {
    "browser.cache.memory.capacity" = 1048576;
    "browser.cache.memory.max_entry_size" = 51200;
    "network.http.max-connections" = 1800;
    "privacy.sanitize.sanitizeOnShutdown" = true;
    "gfx.webrender.all" = true;
   };

  commonPolicies = import ./browser-policies.nix;
  commonContainers = import ./browser-containers.nix;
in
{
  imports = [
    # ./firefox.nix # disabled 2026-09-09 - not needed anymore, kept for reference
    ./librewolf.nix
  ];

  programs.zen-browser = {
    enable = true;

    profiles = {
      # 1. Main Persistent Profile
      persistent = {
        id = 0;
        name = "persistent";
        isDefault = true;

        settings = sharedSettings;

        bookmarks = { force = true; settings = import ../../bookmarks.nix; };
        containersForce = true;
        containers = commonContainers;
      };

      # 2. Burner Ephemeral Profile
      ephemeral = {
        id = 1;
        name = "ephemeral";
        isDefault = false;

        settings = sharedSettings;
        containersForce = true;
        containers = commonContainers;
      };
    };

    policies = commonPolicies // {
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };

        # Bitwarden Password Manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "normal_installed";
        };

        # Firefox Multi-Account Containers
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "normal_installed";
        };

        # Temporary Containers
        "{c607c8df-14a7-4f28-894f-29e8722976af}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
          installation_mode = "normal_installed";
        };

        # SponsorBlock for YouTube
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "normal_installed";
        };

        "vimium-c@gdh1995.cn" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };
  };
}
