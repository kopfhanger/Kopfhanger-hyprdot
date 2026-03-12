{ config, pkgs, ... }:

{
  # AMD 显卡驱动（当前使用）
  services.xserver.videoDrivers = [ "amdgpu" ];

  # NVIDIA 驱动配置（未来可能使用，已注释）
  # hardware.nvidia = {
    # 需要启用 modesetting.
    # modesetting.enable = true;
    # powerManagement.enable = true; # 休眠后唤醒不会花屏
    # powerManagement.finegrained = false;
    # open = false;
    # nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # 为 Xorg 和 Wayland 加载 nvidia 驱动
  # services.xserver.videoDrivers = [ "nvidia" ];
}
