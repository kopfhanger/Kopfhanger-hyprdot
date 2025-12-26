# 编辑此配置文件以定义应在您的系统上安装的内容。
# 帮助信息可在 configuration.nix(5) 手册页
# 及 NixOS 手册中找到（可通过运行 ‘nixos-help’ 访问）。

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # 包括硬件扫描的结果。
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";       # UEFI 固定写法
    theme = inputs.nixos-grub-themes.packages.${pkgs.stdenv.hostPlatform.system}.nixos;
    useOSProber = true;     # 自动探测其他系统
    gfxmodeEfi = "auto";    # 自动检测最佳分辨率
  };
  boot.loader.timeout = 5;

  boot.supportedFilesystems = [
    "ntfs"          # Windows 文件系统
    "btrfs"         # 一些 Linux 发行版使用
    "ext4"          # 标准 Linux 文件系统
    "vfat"          # EFI 分区
    "apfs"          # 苹果系统分区
  ];

  # 使用最新内核
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # 定义hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # 启动网络
  networking.networkmanager.enable = true;

  # 设置时区
  time.timeZone = "Asia/Shanghai";

  # 选择国际化属性
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # 配置X11中的按键映射
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 定义用户账户. 不要忘记使用‘passwd’设置密码.
  users.users.kopfhanger = {
    isNormalUser = true;
    description = "kopfhanger";
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" "video" "audio" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  # 在系统文件中列出要安装的软件. 要搜索，运行:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # 不要忘了安装编辑器以编辑configuration.nix! 已经默认安装了nano.
    os-prober
    efibootmgr
    grub2
  ];

  # 设置vscode的wayland环境变量
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    APPIMAGE_EXTRACT_AND_RUN = "1";
  };

  nix.settings = {
    substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10"
    "https://cache.nixos.org/"
    ];
    experimental-features = ["nix-command" "flakes"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  security.polkit.enable = true;
  security.soteria.enable = true;

  # List services that you want to enable:
  services.dbus.enable = true;
  services.udisks2.enable = true;
  services.v2raya.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  #services.onedrive.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      qt6.qtmultimedia
    ];
  };
  # 使用 Pipewire 启用声音。
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # 自动系统更新
  system.autoUpgrade = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
