{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.trustedInterfaces = [ "waydroid0" ];
    hosts = {
      "0.0.0.0" = [
        "www.arras.io"
        "arras.io"
        "www.arrax.io"
        "arrax.io"
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
    

    params = [
 /*
      "--dpi-desync=fake"
      "--dpi-desync-ttl=3"
      "--dpi-desync-fake-tls=0x00000000"
      "--dpi-desync-fake-tls=!"
      "--dpi-desync-fake-tls-mod=rnd,rndsni,dupsid"
  */
     "--dpi-desync=split2"
      "--dpi-desync-split-pos=midsld"
      "--dpi-desync-fooling=md5sig"
      "--hostcase" 


  ];
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      require_dnssec = true;
      require_nolog = true;
      server_names = [ "cloudflare" "google" ];
    };
  };
}
