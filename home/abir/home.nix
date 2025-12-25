{ config, pkgs, ... }:

{
  home.username = "abir";
  home.homeDirectory = "/home/abir";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    i3
    picom
    rofi
    alacritty
    feh
    xorg.xinit
    xorg.xrandr
    dunst
    nitrogen
    xclip
  ];

  xsession.enable = true;

  # i3 setup
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = ''
      # Use Home Manager Waybar instead of Polybar
      exec --no-startup-id waybar
      exec --no-startup-id picom --experimental-backends --config ${config.home.homeDirectory}/.config/picom/picom.conf
      exec --no-startup-id nm-applet
      exec --no-startup-id dunst
    '';
  };

  # Picom config (copy your old one or use this minimal example)
  home.file.".config/picom/picom.conf".text = ''
    backend = "glx";
    vsync = true;
    shadow = true;
    shadow-radius = 12;
    shadow-opacity = 0.6;
    fade = true;
    fade-delta = 5;
    corner-radius = 8;
    blur-method = "dual_kawase";
    blur-strength = 6;
  '';

  # Alacritty config
  home.file.".config/alacritty/alacritty.yml".text = ''
    window:
      padding:
        x: 8
        y: 8
    font:
      normal:
        family: "JetBrainsMono Nerd Font"
        style: "Regular"
      size: 12.0
    colors:
      primary:
        background: '#1d1f21'
        foreground: '#c5c8c6'
      cursor:
        text: '#1d1f21'
        cursor: '#c5c8c6'
  '';

  # Rofi minimal theme
  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run";
      font: "JetBrainsMono Nerd Font 12";
      show-icons: true;
      theme: "gruvbox-dark";
    }
  '';

  # Waybar config
  home.file.".config/waybar/config".text = ''
    {
      "modules-left": ["sway/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["network", "pulseaudio", "battery"]
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
      background: #1d1f21;
      border: none;
      color: #c5c8c6;
    }
  '';

  # Xinit
  home.file.".xinitrc".text = ''
    exec i3
  '';
}

