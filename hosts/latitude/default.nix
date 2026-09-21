{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../configuration.nix
  ];

  networking.hostName = "latitude";

  boot = {
    kernelParams = [ 

    ];
    initrd.systemd.enable = true; 
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Host-specific hardware support (Intel graphics, thermald, firmware)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  services.thermald.enable = true;
  services.fwupd.enable = true;
  zramSwap.enable = true;

  # Impermanence and file system specifics
  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
      "/var/lib/flatpak"
      "/var/lib/containers"
      "/var/lib/libvirt"
      "/var/lib/tailscale"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  system.stateVersion = "26.11";
}
