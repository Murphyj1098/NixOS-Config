{ pkgs, ... }:

{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/jellyfin" = {
    device = "//barkeith.local.jrmurphy.me/jellyfin";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,nofail,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      user_opts = "iocharset=utf8,vers=3,uid=1000,gid=100";

    in ["${user_opts},${automount_opts},credentials=/etc/nixos/smb-secrets,_netdev"];
  };

  fileSystems."/mnt/personal" = {
    device = "//barkeith.local.jrmurphy.me/jrmurphy";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,nofail,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      user_opts = "iocharset=utf8,vers=3,uid=1000,gid=100";

    in ["${user_opts},${automount_opts},credentials=/etc/nixos/smb-secrets,_netdev"];
  };
}