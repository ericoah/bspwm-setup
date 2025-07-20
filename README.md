# 🪟 bspwm-setup

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
| `flameshot`          | Screenshot tools                 |
| `micro`               | Terminal text editor             |
---

## 🔑 Keybindings Overview

| Key Combo              | Action                                |
|------------------------|----------------------------------------|
| `Super + Enter`        | Launch terminal (alacritty)            |
| `Super + Space`        | Launch rofi                            |
| `Super + Q`            | Close focused window                   |
| `Super + H`            | Help via keybind viewer                |
| `Super + Shift + R`    | Restart bspwm                          |
| `Super + 1-9,0,-,=`    | Switch to workspace 1-12               |
| `Super + Shift + 1-9,0,-,=` | Move window to workspace 1-12     |

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
