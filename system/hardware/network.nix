{ pkgs, systemSettings, ... }:

{
  networking = {
    hostName = systemSettings.hostname;
    firewall.enable = false;
    networkmanager = {
      enable = true;
      dispatcherScripts = [
        {
          type = "basic";
          source = pkgs.writeText "wlan_docking" ''
          #!/usr/bin/env ${pkgs.bash}/bin/bash

          wired_interfaces="en.*|eth.*"
          exclude="enp0s13f0u1u4u3"

          # Lab dock (NixOS ifname):  enp0s13f0u1u4u3

          if [[ "$1" =~ $wired_interfaces ]]; then
              if ! [[ "$1" =~ $exclude ]]; then
                  case "$2" in
                      up)
                          logger "Disabling Wi-Fi"
                          nmcli radio wifi off
                          ;;
                      down)
                          logger "Enabling Wi-Fi"
                          nmcli radio wifi on
                          ;;
                  esac
              else
                  logger "Ethernet interface is on exclude list"
              fi
          else
              logger "Interface is not Ethernet"
          fi
          '';
        }
        {
          type = "basic";
          source = pkgs.writeText "lab_route" ''
          #!/usr/bin/env ${pkgs.bash}/bin/bash

          dock="enp0s13f0u1u4u3"

          # Lab dock (NixOS ifname):  enp0s13f0u1u4u3

          if [[ "$1" =~ $dock ]]; then
            case "$2" in
                up)
                    logger "Adding default route and DNS server"
                    ip r add default via 10.0.0.1
                    echo "nameserver 8.8.8.8" >> /etc/resolv.conf
                    ;;
            esac
          fi
          '';
        }
      ];
    };
  };
}