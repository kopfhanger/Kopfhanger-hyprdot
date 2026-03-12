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
    kazumi
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
    pdfarranger
    freecad
    julia
    paraview
    wechat
    zola
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
   flake = "/etc/nixos/"; # 为您设置 NH_OS_FLAKE 环境变量
  };

  programs.vscode.enable = true;    # 代码编辑器
  programs.foot.enable = true;      # 终端
  programs.satty.enable = true;

  programs.zed-editor = {
    enable = true;
    # package = pkgs.zed-editor.overrideAttrs (old: {
    #   doCheck = false;
    # });
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
     name = "adw-gtk3-dark";
    };
    iconTheme = {
      # 确保 name 与 package 生成的图标主题名称一致
     name = "Papirus";   # 根据你选择的 flavor 可能为 Papirus-Light 或 Papirus
      package = pkgs.catppuccin-papirus-folders.override {
       flavor = "latte";
        accent = "yellow";
      };
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
