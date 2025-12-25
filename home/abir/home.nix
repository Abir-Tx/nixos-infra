{ config, pkgs, ... }:

{
  home.username = "abir";
  home.homeDirectory = "/home/abir";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    i3
    dmenu
    feh
    xorg.xinit
    xorg.xrandr
  ];

  home.file.".xinitrc".text = ''
  exec i3
'';
}

