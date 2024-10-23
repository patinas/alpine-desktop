#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Run setup-alpine for initial configuration
setup-alpine

# Update and upgrade the system
apk update
apk upgrade

# Enable community repository (setup-desktop does this automatically)
# sed -i 's/^#\(.*community\)/\1/' /etc/apk/repositories

# Run the setup-desktop script and select GNOME
echo "Running setup-desktop. Please select 'gnome' when prompted."
setup-desktop gnome

# Create a new user (replace 'user' with desired username)
adduser -g "GNOME User" user
adduser user wheel

# Set up doas for user privileges (optional, similar to sudo)
apk add doas
echo "permit :wheel" > /etc/doas.d/doas.conf

# Reboot the system to apply changes
echo "Installation complete. Please reboot the system."
