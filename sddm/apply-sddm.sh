#!/bin/bash
# Install the customized SDDM Sugar login theme for Fedora Atomic Sway.
#
#   sudo bash sddm/apply-sddm.sh
#
# What it does:
#   1. Installs the theme files into /usr/local/share/sddm/themes/sugar
#      (writable location on Fedora Atomic - /usr/share is read-only)
#   2. Copies the wallpaper where the greeter can read it
#   3. Activates the theme via /etc/sddm.conf.d/10-theme.conf
#
# The theme takes effect at the next login (logout/reboot).
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"

mkdir -p /usr/local/share/sddm/themes/sugar/Components
mkdir -p /usr/local/share/sddm/themes/sugar/Assets
mkdir -p /usr/local/share/sddm/themes/sugar/Backgrounds
mkdir -p /usr/local/share/backgrounds

cp "$HERE/theme/Main.qml"                        /usr/local/share/sddm/themes/sugar/
cp "$HERE/theme/theme.conf"                      /usr/local/share/sddm/themes/sugar/
cp "$HERE/theme/Components/Input.qml"            /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Components/UserList.qml"         /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Components/SessionButton.qml"    /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Components/SystemButtons.qml"    /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Components/VirtualKeyboard.qml"  /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Components/LoginForm.qml"        /usr/local/share/sddm/themes/sugar/Components/
cp "$HERE/theme/Assets/User.svgz"                /usr/local/share/sddm/themes/sugar/Assets/
cp "$HERE/wallpaper.jpg"                         /usr/local/share/sddm/themes/sugar/Backgrounds/background.jpg
cp "$HERE/wallpaper.jpg"                         /usr/local/share/backgrounds/background.jpg

mkdir -p /etc/sddm.conf.d
cp "$HERE/etc-sddm.conf.d/10-theme.conf" /etc/sddm.conf.d/10-theme.conf

echo "Done. The Sugar login theme is active - see it at the next login screen."
