{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.kitty ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.9";
    font_family = "JetBrains Mono";
  };
}