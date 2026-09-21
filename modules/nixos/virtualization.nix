{ config, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # waydroid = {
    #   enable = true;
    #   package = pkgs.waydroid-nftables;
    # };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
