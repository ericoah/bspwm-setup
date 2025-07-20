# 🪟 bspwm-setup

![Made for Debian and Archlinux](https://img.shields.io/badge/Made%20for-Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)

A minimal but functional BSPWM rice script for Arch-based systems.  
Installs all core packages, window manager configs, and themes — ready to go out of the box.

> Based on the [JustAGuy Linux](https://github.com/drewgrif) window manager collection for Debian.

---

## 🚀 Installation

### Quick Install
```bash
git clone https://github.com/ericoah/bspwm-setup.git
cd bspwm-setup
chmod +x install.sh
./install.sh
```

**Package Installation:** Packages are installed in logical groups (core, UI, file manager, audio, utilities, terminal, fonts) for better organization.

### Distribution-Agnostic Installation

<details>
<summary><strong>⚠️ UNSUPPORTED: Instructions for other distributions (click to expand)</strong></summary>

**IMPORTANT:** These instructions are provided as-is for advanced users. Non-Debian distributions are **NOT officially supported**. Package names and availability may vary. Use at your own risk.

**Arch Linux:**
```bash
# Install dependencies (package names may differ)
sudo pacman -S bspwm sxhkd polybar rofi dunst picom thunar \
  xorg-xbacklight pamixer pavucontrol feh flameshot firefox \
  network-manager-applet xfce4-power-manager ttf-font-awesome

# Copy configuration files
./install.sh --only-config
```
```

**Note:** The script can be run from any location - it automatically detects its directory.

---

## 📦 What It Installs

| Component             | Purpose                          |
|------------------------|----------------------------------|
| `bspwm`               | Tiling window manager            |
| `sxhkd`               | Hotkey daemon                    |
| `picom`               | Compositor for transparency      |
| `polybar`             | Status bar                       |
| `rofi`                | Application launcher             |
| `dunst`               | Notifications                    |
| `firefox`             | Default web browser              |
| `thunar` + plugins    | File manager                     |
| `pipewire`            | Audio handling                   |
| `flameshot`,          | Screenshot tools                 |
| `micro`               | Terminal text editor             |
| `qimgv`               | Lightweight image viewer         |

---

## 🔑 Keybindings Overview

| Key Combo              | Action                                |
|------------------------|----------------------------------------|
| `Super + Enter`        | Launch terminal (wezterm)              |
| `Super + Shift + Enter`| Toggle scratchpad terminal             |
| `Super + Space`        | Launch rofi                            |
| `Super + Q`            | Close focused window                   |
| `Super + H`            | Help via keybind viewer                |
| `Super + V`            | Audio mixer (pulsemixer) in scratchpad |
| `Super + Shift + R`    | Restart bspwm                          |
| `Super + 1-9,0,-,=`    | Switch to workspace 1-12               |
| `Super + Shift + 1-9,0,-,=` | Move window to workspace 1-12      |

Keybindings are configured via:

- `~/.config/sxhkd/sxhkdrc`
- `~/.config/bspwm/scripts/help` (run manually or with `Super + H`)

---

## 📂 Configuration Files

```
~/.config/bspwm/
├── bspwmrc                # Main bspwm config
├── sxhkd/
│   └── sxhkdrc            # Keybinding configuration
├── polybar/
│   ├── config.ini
│   └── launch.sh
├── dunst/
│   └── dunstrc
├── rofi/
│   ├── config.rasi
│   └── theme.rasi
├── scripts/
│   ├── changevolume
│   ├── autoresize.sh
│   ├── power
│   ├── scratchpad
│   └── help
├── wallpaper/
│   └── (wallpaper images)
```
