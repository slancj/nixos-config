{ config, pkgs, lib, ... }:

let
  zapretSchoolParams = [
    "--dpi-desync=fake"
    "--dpi-desync-ttl=3"
    "--dpi-desync-fake-tls=0x00000000"
    "--dpi-desync-fake-tls=!"
    "--dpi-desync-fake-tls-mod=rnd,rndsni,dupsid"
  ];

  zapretHomeParams = [
    "--dpi-desync=split2"
    "--dpi-desync-split-pos=midsld"
    "--dpi-desync-fooling=md5sig"
    "--hostcase"
  ];
in
{
  networking = {
    networkmanager.enable = true;
    hosts = {
      "0.0.0.0" = [
        "www.arras.io"
        "arras.io"
        # "www.arrax.io"
        # "arrax.io"
        "www.evowars.io"
        "evowars.io"
        "www.gats.io"
        "gats.io"
        "www.buildroyale.io"
        "buildroyale.io"
        "wyoutube.com"
        "www.wyoutube.com"
        "www.shellshock.io"
        "shellshock.io"
        "florr.io"
        "www.florr.io"
      ];
    };
    nameservers = [ "127.0.0.1" ];
    networkmanager.dns = "none";
    firewall.checkReversePath = "loose";
    firewall.allowedTCPPorts = [ 53317 ];
    firewall.allowedUDPPorts = [ 53317 ];
  };

  services.cloudflare-warp.enable = true;
  services.cloudflared.enable = true;

  services.zapret = {
    enable = true;
    params = zapretSchoolParams; # default / base config = school
  };

  # Build the home profile once, then switch without rebuilding or editing:
  #   zapret-home    (school -> home)
  #   zapret-school  (home -> school/base)
  specialisation.zapret-home.configuration = {
    services.zapret.params = lib.mkForce zapretHomeParams;
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "zapret-home" ''
      exec sudo /nix/var/nix/profiles/system/specialisation/zapret-home/bin/switch-to-configuration test
    '')
    (pkgs.writeShellScriptBin "zapret-school" ''
      exec sudo /nix/var/nix/profiles/system/bin/switch-to-configuration test
    '')
  ];

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      require_dnssec = true;
      require_nolog = true;
      server_names = [ "cloudflare" "google" ];
    };
  };
}
