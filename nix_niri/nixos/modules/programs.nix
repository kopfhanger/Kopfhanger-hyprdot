{ config, pkgs, ... }:

{
# Install firefox.
  #programs.firefox.enable = true;

# 安装  flatpak
  services.flatpak.enable = true;

# 启用 virt-manager 程序
  #programs.virt-manager.enable = flase;

  environment.systemPackages = with pkgs; [
    wget                            # cli下载器
    fastfetch                       # 系统查看
    btop                            # 系统监视器
    fzf                             # 模糊搜索
    fd                              # 快速搜索
    bat                             # 终端的文本编辑器
    ripgrep                         # 按文本搜索
    jq                              # JSON 处理器
    udisks2                         # 磁盘管理
    fishPlugins.tide                # 终端主题
    fishPlugins.fzf-fish            # 模糊搜索插件
    fishPlugins.pisces              # 符号成对
    fishPlugins.forgit              # git插件
    fishPlugins.done                # 命令完成提示
    fishPlugins.bass                # bash支持
    fishPlugins.pure                # 终端提示符
    papirus-icon-theme              # papirus图标主题
    adw-gtk3                        # adw主题
    adwaita-qt                      # adw-qt主题
    sddm-astronaut                  # sddm主题
    xwayland-satellite              # xwayland支持
    onedrive                        # 网盘
    wineWowPackages.waylandFull
    winetricks
 ];

 programs.thunar.enable = true;
 programs.zoxide.enable = true;     # z跳转
 programs.neovim.enable = true;     # 终端文本编辑器
 programs.yazi.enable = true;       # 终端文件管理器
 programs.nautilus-open-any-terminal = {  # 在 nautilus 中打开终端
   enable = true;
   terminal = "foot";
 };
 programs.steam.enable = true;      # steam

 programs.thunar.plugins = with pkgs; [
   thunar-archive-plugin
   thunar-volman
 ];



  # 启用 libvirt 服务，这是使用 virt-manager 的前提
  #virtualisation.libvirtd = {
   # enable = true;
   # 启用 virtiofsd 支持，这会自动处理 qemu 依赖
    #qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  #};
}
