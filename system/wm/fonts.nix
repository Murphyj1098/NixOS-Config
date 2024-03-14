{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    meslo-lgs-nf
  ];
}