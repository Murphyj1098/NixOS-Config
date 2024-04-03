{ config, lib, pkgs, userSettings, ... }:

let
  themePath = "../../../themes/"+("/"+userSettings.theme+"/"+userSettings.theme)+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
in
{
  home.file.".currenttheme".text = userSettings.theme;
  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.base16Scheme = ./. + themePath;
  stylix.fonts = {
    monospace = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    # serif = {
    #   name = userSettings.font;
    #   package = userSettings.fontPkg;
    # };
    # sansSerif = {
    #   name = userSettings.font;
    #   package = userSettings.fontPkg;
    # };
  };

  stylix.targets.kitty.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.rofi.enable = true;

  home.packages = with pkgs; [
     qt5ct pkgs.libsForQt5.breeze-qt5
  ];
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  programs.bash.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
  };
}
