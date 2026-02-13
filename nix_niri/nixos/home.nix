{ config, pkgs, ... }:

{
  home.username = "kopfhanger";
  home.homeDirectory = "/home/kopfhanger";

  home.packages = with pkgs;[
    appimage-run      # AppImage运行器
    nautilus          # 文件管理器
    code-nautilus     # 在此打开code
    qq                # qq
    swaylock          # 锁屏
    evince            # 文档查看器
    obsidian          # 笔记管理软件
    thunderbird       # 邮件
    drawio            # 绘图工具
    texliveFull       # latex
    vlc               # 媒体播放器
    thonny            # python开发环境
    typora            # markdown编辑器
    loupe             # 屏幕缩放工具
    listen1
    conda
    python3           # 编程
    python3Packages.pip # 包管理
    gnuplot
    ocrmypdf
    jujutsu
    texstudio
    # kazumi
    telegram-desktop
    gimp
    qbittorrent
    mission-center
    inkscape
    blender
    libreoffice-fresh
    lutris
    protonplus
    umu-launcher
    nix-output-monitor
    freefilesync
    microsoft-edge
    google-chrome
    bazaar
    obs-studio
    zotero
    xournalpp
    wpsoffice-cn
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/"; # sets NH_OS_FLAKE variable for you
  };

  programs.vscode.enable = true;    # 代码编辑器
  programs.foot.enable = true;      # 终端

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor.overrideAttrs (old: {
      doCheck = false;
    });
  };

  programs.git = {
    enable = true;
    settings.user.name = "kopfhanger";
    settings.user.email = "xinyangzengyike@qq.com";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark"; # 主题名称
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      # 可选变体：Papirus, Papirus-Dark, Papirus-Light
      name = "Papirus";
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  }; # 为nautilus配置主题

  qt.enable = true;
  qt.style.name = "adwaita-dark";

  home.stateVersion = "25.11";
}
