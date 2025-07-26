#!/bin/bash

# JustAGuy Linux - BSPWM Setup
# https://github.com/drewgrif/bspwm-setup

set -e

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/bspwm"
FONTS_DIR="$HOME/.local/share"
TEMP_DIR="/tmp/bspwm_$$"
LOG_FILE="$HOME/bspwm-install.log"

# Logging and cleanup
exec > >(tee -a "$LOG_FILE") 2>&1
trap "rm -rf $TEMP_DIR" EXIT

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

die() { echo -e "${RED}ERROR: $*${NC}" >&2; exit 1; }
msg() { echo -e "${CYAN}$*${NC}"; }


read -p "Install BSPWM? (y/n) " -n 1 -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

# Update system
    msg "Updating system..."
    sudo pacman -Syyu

# Package groups for better organization
PACKAGES_CORE=(
#    xorg xorg-dev xbacklight xbindkeys xvkbd xinput
#    build-essential bspwm sxhkd xdotool
#    libnotify-bin libnotify-dev
    xorg-server xorg-xinit xorg-xbacklight xbindkeys xorg-xinput
    base-devel bspwm sxhkd xdotool
    libnotify

)

PACKAGES_UI=(
 #   polybar rofi dunst feh lxappearance network-manager-gnome
    polybar rofi picom dunst feh lxappearance network-manager-applet
)

PACKAGES_FILE_MANAGER=(
#    thunar thunar-archive-plugin thunar-volman
#    gvfs-backends dialog mtools smbclient cifs-utils ripgrep fd-find unzip
    thunar thunar-archive-plugin thunar-volman
    gvfs dialog mtools smbclient cifs-utils ripgrep fd unzip
 )

PACKAGES_AUDIO=(
#    pavucontrol pulsemixer pamixer pipewire-audio
    pavucontrol pulsemixer pamixer pipewire-pulse
)

PACKAGES_UTILITIES=(
#    avahi-daemon acpi acpid xfce4-power-manager
#    flameshot qimgv nala micro xdg-user-dirs-gtk
    avahi acpi acpid xfce4-power-manager flameshot
    firefox xdg-user-dirs-gtk micro neovim leafpad git curl wget openssh
 )

PACKAGES_TERMINAL=(
#    suckless-tools
    alacritty kitty eza
)

PACKAGES_FONTS=(
#    fonts-recommended fonts-font-awesome fonts-terminus
    ttf-font-awesome terminus-font ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-meslo-nerd noto-fonts 
)

PACKAGES_BUILD=(
#    cmake meson ninja-build curl pkg-config
    cmake meson ninja curl pkgconf
)


# Install packages by group
    msg "Installing core packages..."
    sudo pacman -S --noconfirm "${PACKAGES_CORE[@]}" || die "Failed to install core packages"

    msg "Installing UI components..."
    sudo pacman -S --noconfirm "${PACKAGES_UI[@]}" || die "Failed to install UI packages"

    msg "Installing file manager..."
    sudo pacman -S --noconfirm "${PACKAGES_FILE_MANAGER[@]}" || die "Failed to install file manager"

    msg "Installing audio support..."
    sudo pacman -S --noconfirm "${PACKAGES_AUDIO[@]}" || die "Failed to install audio packages"

    msg "Installing system utilities..."
    sudo pacman -S --noconfirm "${PACKAGES_UTILITIES[@]}" || die "Failed to install utilities"

    msg "Installing terminal tools..."
    sudo pacman -S --noconfirm "${PACKAGES_TERMINAL[@]}" || die "Failed to install terminal tools"

    msg "Installing fonts..."
    sudo pacman -S --noconfirm "${PACKAGES_FONTS[@]}" || die "Failed to install fonts"

    msg "Installing build dependencies..."
    sudo pacman -S --noconfirm "${PACKAGES_BUILD[@]}" || die "Failed to install build tools"

    # Enable services
    sudo systemctl enable acpid
    sudo systemctl enable sshd

# Handle existing config
if [ -d "$CONFIG_DIR" ]; then
    clear
    read -p "Found existing bspwm config. Backup? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$CONFIG_DIR" "$CONFIG_DIR.bak.$(date +%s)"
        msg "Backed up existing config"
    else
        clear
        read -p "Overwrite without backup? (y/n) " -n 1 -r
        echo
        [[ $REPLY =~ ^[Yy]$ ]] || die "Installation cancelled"
        rm -rf "$CONFIG_DIR"
    fi
fi

# Copy configs
msg "Setting up configuration..."
mkdir -p "$CONFIG_DIR"

# Copy bspwm config files
cp "$SCRIPT_DIR"/bspwmrc "$CONFIG_DIR"/ || die "Failed to copy bspwmrc"

# Copy configuration directories
for dir in dunst fonts picom polybar rofi scripts sxhkd; do
    if [ -d "$SCRIPT_DIR/$dir" ]; then
        cp -r "$SCRIPT_DIR/$dir" "$CONFIG_DIR"/ || die "Failed to copy $dir"
    else
        msg "Warning: $dir directory not found, skipping..."
    fi
done

# Make scripts executable
chmod +x "$CONFIG_DIR"/bspwmrc
find "$CONFIG_DIR"/polybar/forest/scripts -type f -exec chmod +x {} \; 2>/dev/null || true

# Setup directories
xdg-user-dirs-update

cp -r $SCRIPT_DIR/wallpaper "$CONFIG_DIR"/ || die "Failed to copy wallpaper directory"

# Fonts
mkdir -p $FONTS_DIR
mv $SCRIPT_DIR/fonts "$FONTS_DIR"/ || die "Failed to copy wallpaper directory"
fc-cache -f

# Done
echo -e "\n${GREEN}Installation complete!${NC}"
