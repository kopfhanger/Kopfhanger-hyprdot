# virtualization.nix
{pkgs, ...}: {
  # 仅启用 docker 或 podman 其中之一 -- 不要同时启用
  #virtualisation = {
   # docker = {
   #   enable = true;
   # };

    #podman.enable = false;

    #libvirtd = {
     # enable = true;
     # onBoot = "start";
     # onShutdown = "shutdown";
     # qemu = {
     #   runAsRoot = false;
     #   # ovmf 子模块已移除：所有 OVMF 镜像现在在 nixpkgs-unstable 中默认可用
     #   swtpm.enable = true; # TPM 模拟
     #   verbatimConfig = ''
     #     user= "qemu-libvirtd"
     #     group = "kvm"
     #     dynamic_ownership = 1
     #     remember_owner = 0
     #   '';
     # };
     # allowedBridges = [
     #   "virbr0" # 默认 NAT 桥接
     #   "br0" # 自定义桥接（如需要）
     # ];
    #};

    # 提升 VM 性能的内核模块
   # spiceUSBRedirection.enable = true;
 # };

  #programs = {
  # virt-manager.enable = true;
  #  dconf.enable = true; # virt-manager 配置所需
  #};

  environment.systemPackages = with pkgs; [
    #virt-viewer # 查看虚拟机
    #lazydocker
    #docker-client
    #qemu_kvm # KVM 支持
    #OVMF # UEFI 固件
    swtpm # TPM 模拟
    #libguestfs # VM 磁盘工具
    #virt-top # 监控 VM 性能
    #spice # SPICE 协议支持
    #spice-gtk # SPICE 客户端 GTK
    #spice-protocol # SPICE 协议头
    #virglrenderer # 虚拟 GPU 支持
    mesa # VM OpenGL 支持
  ];

  # 启用必要的内核模块以提升 VM 性能
  #boot.kernelModules = ["kvm-amd" "kvm-intel" "vfio-pci"];

  # 添加启动内核参数以改善图形支持
  # boot.kernelParams = [
  #   "intel_iommu=on"
  #   "iommu=pt"
  # ];

  # 启用 OpenGL 支持
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 创建默认的 ISO 和 VM 目录并设置正确权限
  #systemd.tmpfiles.rules = [
  #  "d /var/lib/libvirt/isos 0755 qemu-libvirtd kvm -"
  #  "d /var/lib/libvirt/images 0755 qemu-libvirtd kvm -"
  #];

  # 虚拟化服务（已注释，需要时取消注释）
  # virtualisation.docker.enable = true;
  # virtualisation.podman.enable = true;
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
}
