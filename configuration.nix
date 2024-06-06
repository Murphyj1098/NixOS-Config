{ lib, pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./system/hardware-configuration.nix
      ./system/app/nano.nix
      ./system/hardware/cifs-mount.nix
      ./system/hardware/network.nix
      ./system/hardware/bluetooth.nix
      ./system/wm/wayland.nix
      ./system/style/stylix.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
        theme = "/boot/grub/themes/dracula";
        splashImage = "/boot/grub/themes/dracula/background.png";
        backgroundColor = "#282a36";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 5;
    };
  };

  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  security.polkit.enable = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [];
    uid = 1000;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  system.stateVersion = "23.11"; # Do not change this value

}

