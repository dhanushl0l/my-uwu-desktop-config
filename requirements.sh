#!/bin/bash

# Package categories
PACMAN_PACKAGES=(
    imv
    rofi-wayland
    tesseract
    hyprlock
    hyprpaper
    e2fsprogs
    ntfs-3g
    lsd
    mpv
    hypridle
    pavucontrol
    nautilus
    android-tools
    android-udev
    gvfs-mtp
    gvfs-gphoto2
    libmtp
)

AUR_PACKAGES=(
    fish-git
    rofi-emoji-git
    ttf-material-design-iconic-font
)

FONTS_PACKAGES=(
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-firacode-nerd
)

# Function to automate yay installation
install_yay() {
    echo "yay is not installed. Installing yay..."
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit 1
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    echo "yay installed successfully."
}

# Function to install Starship
install_starship() {
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init fish)"' >>~/.config/fish/config.fish
    echo "Starship installed and configured for Fish shell."
}

# Ensure yay is installed
if ! command -v yay &>/dev/null; then
    install_yay
else
    echo "yay is already installed."
fi

# Install packages using pacman
echo "Installing packages using pacman..."
sudo pacman -Syu --noconfirm --needed "${PACMAN_PACKAGES[@]}"

# Install AUR packages using yay
echo "Installing AUR packages using yay..."
yay -S --noconfirm --needed "${AUR_PACKAGES[@]}"

# Install font packages
echo "Installing font packages using pacman..."
sudo pacman -S --noconfirm --needed "${FONTS_PACKAGES[@]}"

# Check and install Starship
if ! command -v starship &>/dev/null; then
    install_starship
else
    echo "Starship is already installed."
fi

echo "All packages, fonts, and Starship installed successfully!"
