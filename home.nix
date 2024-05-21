{ config, pkgs, stylix, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  
  programs.home-manager.enable = true;

  imports = [
    stylix.homeManagerModules.stylix
    ./user/app/git/git.nix
    ./user/app/terminal/kitty.nix
    ./user/wm/hyprland.nix
    ./user/shell/sh.nix
    ./user/style/stylix.nix
  ];

  home.packages = with pkgs; [

    # CLI Utils/Toys
    fastfetch
    tree
    bat
    (pkgs.callPackage ./user/pkgs/pokemon-colorscripts.nix { })

    # Window Manager + Addons
    libnotify     # for mako
    swww          # Wallpaper (swap this out for hyprpaper?)
    pavucontrol   # Volume Menu

    # Apps
    firefox
    vscode-fhs
    spotify
    kitty
    discord
    godot_4

    # Other
    python3Full
  
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = null;
    videos = null;
    pictures = null;
    templates = null;
    desktop = null;
    publicShare = null;
  };

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  home.stateVersion = "23.11"; # Do not change this value
}
