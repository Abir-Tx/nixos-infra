{ config, pkgs, ... }:

{
  # Basic Info
  home.username = "abir";
  home.homeDirectory = "/home/abir";

  programs.home-manager.enable = true;


  # User Packages (Installs only for this user)
  home.packages = with pkgs; [
    neofetch
    firefox
    alacritty
    i3
    rofi
    nitrogen
    feh
    picom
    xorg.xinit
    xorg.xrandr
    font-awesome
  ];


# Allow startx to work
  home.file.".xinitrc".text = ''
  exec i3
'';

  # i3 config
  #xsession.windowManager.i3 = {
 #   enable = true;
 #   extraConfig = builtins.readFile ./i3/config;
 # };



# 2. The Hybrid Move: Source your existing file
  # This puts your file at ~/.config/i3/config
#  xdg.configFile."i3/config".source = ./i3/config;

# The Rice (i3wm Config)
  xsession.windowManager.i3 = {
    enable = true;
    config = null;
    extraConfig = builtins.readFile ./i3/config;

  };

  # Git Config
  programs.git = {
    enable = true;
    userName = "Mushfiqur Rahman Abir";
    userEmail = "28858998+Abir-Tx@users.noreply.github.com";
  };

  # Bash/Zsh aliases
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos-lab";
    };
  };

  # Don't touch this
  home.stateVersion = "24.05";
}

