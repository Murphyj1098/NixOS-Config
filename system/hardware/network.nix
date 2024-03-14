{ systemSettings, ... }:

{
  networking = {
    hostName = systemSettings.hostname;
    firewall.enable = false;
    networkmanager = {
      enable = true;
      # dispatcherScripts = [
      #   {
      #     type = "basic";
      #     source = ./scripts/wlan_docking.sh;
      #   }
      # ];
    };
  };
}