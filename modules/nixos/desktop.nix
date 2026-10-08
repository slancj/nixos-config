{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Display Manager and Windowing
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd \"uwsm start hyprland-uwsm.desktop\"";
        user = "greeter";
      };
    };
  };
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Sound/Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Printing (CUPS) — imperative only, persisted via /var/lib/cups
  # (/etc/cups is a symlink there). Add once via system-config-printer,
  # http://localhost:631, or lpadmin and it survives reboots.
  # No hardware.printers.ensurePrinters (fails cups.service when off-site),
  # no Avahi/browsed (only needed for mDNS auto-discovery).
  services.printing = {
    enable = true;
    drivers = with pkgs; [ cups-filters ];
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

  # File Manager (Thunar) and support services
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports for local network transfers
  };
}
