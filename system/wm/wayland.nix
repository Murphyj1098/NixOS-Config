{ ... }:

{
  imports = [
    ./fonts.nix
    ./pipewire.nix
    ./hyprland.nix
  ];

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}