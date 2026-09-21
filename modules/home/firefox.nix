{
  config,
  pkgs,
  lib,
  ...
}:

let
  ffultima-src = builtins.fetchTarball {
    url = "https://github.com/soulhotel/FF-ULTIMA/archive/refs/tags/v4.3.tar.gz";
    sha256 = "0cpwxr70xfd43pf08jqsm8jbni71gjg393qczcmd35ccwnpj3kfa";
  };

  # Fetch Betterfox user.js
  betterfox-js = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/152.0/user.js";
    sha256 = "0z3b44q82ambb4mr9bhmbalfk4a1m5b3zs3d6w05nzg4wcb8kfd6";
  };

  betterfoxConfig = builtins.readFile betterfox-js;
  ffultimaConfig = builtins.readFile "${ffultima-src}/user.js";

  # Helper to format Nix attrsets as user_pref lines for user.js
  mkUserJs = prefs: lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value:
      let
        valStr =
          if builtins.isBool value then (if value then "true" else "false")
          else if builtins.isInt value then builtins.toString value
          else if builtins.isString value then ''"${value}"''
          else throw "Unsupported type for preference: ${name}";
      in
        "user_pref(\"${name}\", ${valStr});"
    ) prefs
  );

  ephemeralSettings = {
    # UI/UX
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "svg.context-properties.content.enabled" = true;
    "sidebar.verticalTabs" = true;
    "devtools.chrome.enabled" = true;
    "user.theme.catppuccin-mocha" = true;
    "browser.tabs.closeWindowWithLastTab" = false;
    "privacy.trackingprotection.allow_list.baseline.enabled" = true;

    # DNS over HTTPS (Cloudflare)
    "network.trr.mode" = 2;
    "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
    "network.trr.bootstrapAddress" = "1.1.1.1";

    # Privacy - clear on shutdown
    "privacy.sanitize.sanitizeOnShutdown" = true;
    "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
    "privacy.clearOnShutdown_v2.cache" = true;
    "privacy.clearOnShutdown_v2.formdata" = true;
    "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
    "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
    "privacy.clearOnShutdown_v2.siteSettings" = false;
    "ultima.sidebery.autohide" = false;
    "ultima.tabs.tabbar.disabled" = true;
    "devtools.debugger.remote-enabled" = true;
    "devtools.browsertoolbox.scope" = "parent-process";

    "widget.use-xdg-desktop-portal.file-picker" = 1;

    "browser.cache.memory.capacity" = 1048576;
    "browser.cache.memory.max_entry_size" = 51200;

    "network.http.max-connections" = 1800;

    "extensions.webextensions.uuids" = builtins.toJSON {
      "{3c078156-979c-498b-8990-85f7987dd929}" = "e5d248a5-5a80-437b-bc6a-3b29f7c1b957";
    };

    "browser.newtabpage.pinned" = builtins.toJSON [
      {
        title = "NixOS Search";
        url = "https://search.nixos.org";
      }
      {
        title = "GitHub";
        url = "https://github.com";
      }
      {
        title = "Reddit";
        url = "https://reddit.com";
      }
      {
        title = "YouTube";
        url = "https://youtube.com";
      }
    ];
  };

  persistentSettings = ephemeralSettings // {
    # Don't clear on shutdown
    
    "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;

    # Restore session tabs on startup
    "browser.startup.page" = 3;
  };

  # NOTE: extensions were previously sourced from NUR rycee.firefox-addons.
  # NUR removed, so no declarative extensions here. Install manually or via policies.
  commonExtensions = [ ];

  firefoxExtensions = commonExtensions;

  # Shared with zen-browser
  commonPolicies = import ./browser-policies.nix;
  commonContainers = import ./browser-containers.nix;
in
{
  programs.firefox = {
    enable = true;

    policies = commonPolicies;

    profiles = {
      ephemeral = {
        id = 0;
        name = "ephemeral";
        path = "ephemeral";
        isDefault = true;
        settings = ephemeralSettings;
        bookmarks = { force = true; settings = import ../../bookmarks.nix; };
        extraConfig = betterfoxConfig + "\n" + ffultimaConfig + "\n" + (mkUserJs ephemeralSettings);
        extensions.packages = firefoxExtensions;
        containersForce = true;
        containers = commonContainers;
      };

      persistent = {
        id = 1;
        name = "persistent";
        path = "persistent";
        isDefault = false;
        settings = persistentSettings;
        bookmarks = { force = true; settings = import ../../bookmarks.nix; };
        extraConfig = betterfoxConfig + "\n" + ffultimaConfig + "\n" + (mkUserJs persistentSettings);
        extensions.packages = firefoxExtensions;
        containersForce = true;
        containers = commonContainers;
      };
    };
  };

  # Apply FF-ULTIMA theme to Firefox profiles
  xdg.configFile."mozilla/firefox/ephemeral/chrome".source = ffultima-src;
  xdg.configFile."mozilla/firefox/persistent/chrome".source = ffultima-src;
}