{ config, pkgs, ... }:

{
# Install firefox.
  #programs.firefox.enable = true;

# 安装  flatpak
  #services.flatpak.enable = false;
  
# 启用 virt-manager 程序
  #programs.virt-manager.enable = flase;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    fastfetch
    btop
    yazi
    zoxide
    fzf
    fd
    bat
    ripgrep
    fishPlugins.tide
    fishPlugins.fzf-fish
    fishPlugins.pisces
    fishPlugins.forgit
    fishPlugins.done
    fishPlugins.bass
    fishPlugins.pure
    papirus-icon-theme
    adw-gtk3
    adwaita-qt
    sddm-astronaut
    onedrive
 ];

  # 启用 libvirt 服务，这是使用 virt-manager 的前提
  #virtualisation.libvirtd = {
   # enable = true;
   # 启用 virtiofsd 支持，这会自动处理 qemu 依赖
    #qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  #};
}
