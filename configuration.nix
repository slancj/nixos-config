{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/nixos
  ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  services.journald.settings.Journal = {
    SystemMaxUse = "500M";
    SystemMaxFileSize = "50M";
    RuntimeMaxUse = "100M";
  };

  systemd.coredump.settings.Coredump = {
    Storage = "external";
    Compress = "yes";
    MaxUse = "500M";
    KeepFree = "1G";
  };

  programs.fuse.userAllowOther = true;
  services.tlp.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  services.tailscale.enable = true;
  # Enable GNOME Keyring daemon system-wide
  services.gnome.gnome-keyring.enable = true;

  # Enable PAM auto-unlock for both tty login AND gdm graphical login
  security.pam.services = {
    login.enableGnomeKeyring = true;
    gdm.enableGnomeKeyring = true;
    gdm-password.enableGnomeKeyring = true;
  };
  security.polkit.enable = true;

  users.users = {
    root = {
      hashedPassword = "$y$j9T$FT36B0y7klaP4SEG3eAmL/$Q5BUfiiwJgJbQ.3S6nZCXBnPJVXSZw4VbT.lIqEFFg9";
    };

    trueking = {
      isNormalUser = true;
      description = "trueking";
      shell = pkgs.zsh; 
      extraGroups = [ "networkmanager" "wheel" "input" "video" ];
      hashedPassword = "$y$j9T$FT36B0y7klaP4SEG3eAmL/$Q5BUfiiwJgJbQ.3S6nZCXBnPJVXSZw4VbT.lIqEFFg9";
    };
  };

  programs = {
    mosh.enable = true;
    git.enable = true;
    kdeconnect.enable = true;
    zsh.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  programs.nh = {
    enable = true;
    flake = "/persist/etc/nixos";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    cloudflared
    curl
    dnsutils
    distrobox
    steam-run
    vim
    wget
    tree
    killall
    file
    ripgrep
    fzf
    btop
    eza
    tmux
    nmap
    tcpdump
    mtr
    file-roller # The GUI archive manager
    _7zz        # Support for .7z
    unrar       # Support for .rar
    unzip       # Support for .zip
    zip
    gcc
    gnumake
    openvpn
    proxychains-ng
    pre-commit
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };


  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      auto-optimise-store = true;
    };
  };
}
