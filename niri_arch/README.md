# Niri 配置 - Arch Linux + Noctalia 版本

这是为 Arch Linux 系统适配的 Niri Wayland 合成器配置，保留完整的 Noctalia 功能。

## 📦 依赖安装

### 基础依赖
```bash
# Niri 本身（从 AUR 安装）
yay -S niri-git

# 或者使用官方仓库（如果可用）
sudo pacman -S niri
```

### Noctalia（必需）
```bash
# 从 AUR 安装 Noctalia
yay -S noctalia-shell

# 或者使用开发版本
yay -S noctalia-shell-git
```

**重要提示**：Noctalia 依赖于 Quickshell，安装时会自动处理依赖关系。

### 必需依赖
```bash
# 终端模拟器
sudo pacman -S foot alacritty

# 应用启动器（备选）
yay -S wofi  # 或 fuzzel

# Fuzzel（推荐与 Noctalia 配合使用）
sudo pacman -S fuzzel

# 截图工具
sudo pacman -S grim slurp swappy satty

# 亮度控制
sudo pacman -S brightnessctl

# 音频控制
sudo pacman -S wireplumber  # 提供 wpctl 命令

# 文件管理器
sudo pacman -S nautilus

# Zen Browser（如果使用）
yay -S zen-browser
```

### 可选依赖
```bash
# 状态栏
yay -S waybar

# 锁屏（Noctalia 内置，也可用 swaylock）
sudo pacman -S swaylock-effects

# 背景设置
sudo pacman -S swaybg

# 通知守护进程
sudo pacman -S dunst
```

## 🎨 字体和图标

```bash
# 安装常用字体
sudo pacman -S ttf-jetbrains-mono-nerd ttf-font-awesome

# 安装光标主题
yay -S bibata-cursor-theme
```

## ⚙️ 配置说明

### 配置文件位置
```
~/.config/niri/config.kdl
```

### 使用方法
1. 复制配置文件到配置目录：
```bash
mkdir -p ~/.config/niri
cp -r ~/workspace/Kopfhanger-hyprdot/niri_arch/* ~/.config/niri/
```

2. 根据需要修改配置文件：
   - `config.kdl` - 主配置文件
   - `binds.kdl` - 快捷键绑定
   - `input.kdl` - 输入设备配置
   - `layout.kdl` - 布局与外观
   - `outputs.kdl` - 显示器配置

3. 启动 Niri：
```bash
# 如果使用 display manager (gdm, sddm 等)
# 在登录界面选择 Niri 会话

# 或者手动启动
niri
```

## 🔧 主要修改点（相比 NixOS 版本）

### 1. **Noctalia 启动命令**
```kdl
// NixOS: spawn-at-startup "noctalia-shell"
// Arch Linux: 
spawn-at-startup "qs" "-c" "noctalia-shell"
```

### 2. **Noctalia IPC 调用命令**
所有 Noctalia IPC 调用都需要使用 `qs -c noctalia-shell ipc call` 格式：

| 功能 | NixOS 格式 | Arch Linux 格式 |
|------|-----------|----------------|
| 控制面板 | `noctalia-shell ipc call controlCenter toggle` | `qs -c noctalia-shell ipc call controlCenter toggle` |
| 设置 | `noctalia-shell ipc call settings toggle` | `qs -c noctalia-shell ipc call settings toggle` |
| 锁屏 | `noctalia-shell ipc call lockScreen lock` | `qs -c noctalia-shell ipc call lockScreen lock` |
| 启动器 | `noctalia-shell ipc call launcher toggle` | `qs -c noctalia-shell ipc call launcher toggle` |

### 3. **环境变量**
添加了 Arch Linux 通用的环境变量：
- `QT_QPA_PLATFORM` - Qt 平台插件
- 输入法相关变量（已注释，按需启用）

### 4. **其他配置保持不变**
- ✅ Noctalia 启动项完整保留（仅调整格式）
- ✅ Noctalia 快捷键绑定完整保留（仅调整命令格式）
- ✅ Noctalia 窗口规则完整保留
- ✅ 所有 Noctalia 功能完整保留

## 🎯 默认快捷键

### Noctalia 相关
| 快捷键 | 功能 |
|--------|------|
| `Mod + Space` | Noctalia 应用启动器 |
| `Mod + S` | Noctalia 控制面板 |
| `Mod + ,` | Noctalia 设置 |
| `Super + Alt + L` | Noctalia 锁屏 |

### 基础功能
| 快捷键 | 功能 |
|--------|------|
| `Mod + Return` | 打开终端 (foot) |
| `Mod + Q` | 关闭窗口 |
| `Mod + H/J/K/L` | 移动焦点 |
| `Mod + Ctrl + H/J/K/L` | 移动窗口 |
| `Mod + 1-9` | 切换到工作区 1-9 |
| `Mod + Shift + E` | 退出 Niri |

## 🐛 常见问题

### 1. **Noctalia 不启动**
确保已正确安装 noctalia-shell：
```bash
yay -S noctalia-shell
```

检查 qs（Quickshell）是否在 PATH 中：
```bash
which qs
```

手动测试启动命令：
```bash
qs -c noctalia-shell
```

### 2. **快捷键无法触发 Noctalia 功能**
确保使用正确的命令格式：
```bash
# 测试控制面板
qs -c noctalia-shell ipc call controlCenter toggle

# 测试启动器
qs -c noctalia-shell ipc call launcher toggle
```

如果命令有效，但快捷键无效，检查 `binds.kdl` 中的语法是否正确。

### 3. **音量控制不工作**
确保已安装 `wireplumber` 并运行：
```bash
systemctl --user enable --now wireplumber
```

### 4. **亮度控制不工作**
确保用户已加入 `video` 组：
```bash
sudo usermod -aG video $USER
```

### 5. **中文输入法**
如需使用 fcitx5，在 `config.kdl` 的环境变量部分添加：
```kdl
environment {
    GTK_IM_MODULE "fcitx5"
    QT_IM_MODULE "fcitx5"
    XMODIFIERS "@im=fcitx5"
}
```

然后重启 Niri。

## 📝 自定义建议

1. **显示器配置**：根据实际显示器修改 `outputs.kdl`
2. **键盘布局**：在 `input.kdl` 中调整 XKB 布局
3. **快捷键**：在 `binds.kdl` 中自定义快捷键（Noctalia 部分保持原样）
4. **外观**：在 `layout.kdl` 中调整窗口圆角、边框等

## 🔗 Noctalia 相关资源

- [Noctalia GitHub](https://github.com/noctalia-shell/noctalia)
- [Noctalia 配置文档](https://github.com/noctalia-shell/noctalia/wiki)

## 🔗 Niri 相关资源

- [Niri GitHub](https://github.com/YaLTeR/niri)
- [Niri KDL 配置文档](https://github.com/YaLTeR/niri/wiki/Configuration)
- [Arch Wiki - Niri](https://wiki.archlinux.org/title/Niri)
