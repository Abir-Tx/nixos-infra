{ config, pkgs, ... }:

{
  home.username = "abir";
  home.homeDirectory = "/home/abir";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    i3
    rofi
    feh
    picom
    xorg.xinit
    xorg.xrandr
  ];

  home.file.".xinitrc".text = ''
  exec i3
'';

  # i3 config
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = builtins.readFile ./i3/config;
  };


    # Alacritty
  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./alacritty/alacritty.yml);
  };

  # Picom
  services.picom = {
    enable = true;
    configFile = ./picom/picom.conf;
  };


}

