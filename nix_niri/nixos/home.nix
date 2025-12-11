{ config, pkgs, ... }:

{
  home.username = "kopfhanger";
  home.homeDirectory = "/home/kopfhanger";

  home.packages = with pkgs;[
    foot
    nautilus
    qq
    wechat-uos
    swaylock
    zed-editor
    vscode
    evince
    obsidian
    thunderbird
    onedrive
    drawio
    steam
    texliveFull
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  programs.git = {
    enable = true;
    settings.user.name = "kopfhanger";
    settings.user.email = "xinyangzengyike@qq.com";
  };

  gtk.enable = true;
  gtk.theme = {
    package = pkgs.adw-gtk3; 
    name = "adw-gtk3-dark"; # 主题名称
  };
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    # 可选变体：Papirus, Papirus-Dark, Papirus-Light
    name = "Papirus";
  };

  qt.enable = true;
  qt.style.name = "adwaita-dark";

  home.stateVersion = "25.11";
}

