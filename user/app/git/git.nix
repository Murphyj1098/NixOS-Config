{ pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.userName = "Murphyj1098";
  programs.git.userEmail = "jrmurphy@wpi.edu";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    diff.colorMoved = "zebra";
    pull.rebase = false;
  };
}