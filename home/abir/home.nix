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
    meslo-lgs-nf
  ];


# Allow startx to work
  home.file.".xinitrc".text = ''
  exec i3
'';

# SHELL VARIABLES
home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim"; # Some apps use VISUAL instead of EDITOR
  };

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


  # picom conf
  services.picom = {
    enable = true;
    
    # This disables the Nix-generated settings to avoid conflicts
    # (e.g., if your file sets 'backend = glx' but Nix sets 'backend = xrender')
    # We basically tell Nix: "Don't try to be smart, just run Picom."
    package = pkgs.picom; # You can swap this for pkgs.picom-pijulius if you want animations
    
    # Do not manage individual settings here (like shadow = true;)
    # Instead, ignore them and point to your file.
  };

  # Link your config file to the standard location
  xdg.configFile."picom/picom.conf".source = ./picom/picom.conf;


  # Alacritty Conf
  # 1. Enable Alacritty (so the binary is installed)
  programs.alacritty.enable = true;

  # Link the CONFIG folder - alacritty
  # This makes ~/.config/alacritty point to your dotfiles/alacritty
  xdg.configFile."alacritty".source = ./alacritty;


  # 1. Enable the Program
  programs.i3status-rust = {
    enable = true;
    
    # 2. Define the Bar named "bottom" (or "top")
    bars = {
      bottom = {
        theme = "ctp-mocha"; # Catppuccin Mocha theme (matches your Alacritty)
        icons = "awesome6"; # FontAwesome 6 icons
        
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon_swap $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "net";
            format = " $icon $ip $signal_strength ";
            interval = 5;
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
        ];
      };
    };
  };

  # Don't touch this
  home.stateVersion = "24.05";
}

