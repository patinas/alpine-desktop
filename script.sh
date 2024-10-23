#!/bin/bash

# Update and upgrade system
apk update
apk upgrade

# Enable community repository
sed -i 's/^#\(.*community\)/\1/' /etc/apk/repositories

# Install necessary base packages
apk add bash bash-completion dbus elogind polkit eudev

# Install X.Org server and video drivers
setup-xorg-base
apk add xf86-video-vesa xf86-video-intel xf86-video-nouveau xf86-video-amdgpu

# Install input drivers
apk add xf86-input-libinput

# Install GNOME and related packages
apk add gnome gnome-apps gdm networkmanager

# Install additional useful applications
apk add firefox-esr gedit gnome-terminal gnome-system-monitor

# Enable necessary services
rc-update add dbus
rc-update add elogind
rc-update add polkit
rc-update add gdm
rc-update add networkmanager

# Start services
rc-service dbus start
rc-service elogind start
rc-service polkit start
rc-service gdm start
rc-service networkmanager start

# Create a new user (replace 'username' with desired username)
adduser -g "GNOME User" user
adduser user wheel

# Set up sudo for the new user
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel

# Set GNOME as the default session
echo "[User]" > /var/lib/AccountsService/users/user
echo "XSession=gnome" >> /var/lib/AccountsService/users/user

# Reboot the system
echo "Installation complete. Rebooting in 10 seconds..."
sleep 10
reboot
