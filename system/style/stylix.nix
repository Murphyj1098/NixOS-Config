{ lib, pkgs, stylix, userSettings, ... }:

let
  themePath = "../../../themes/"+userSettings.theme+"/"+userSettings.theme+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
in
{
  imports = [ stylix.nixosModules.stylix ];

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

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
