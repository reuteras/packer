#!/bin/bash

# remnux-tools installs Google Chrome on amd64 and Chromium on arm64.
BROWSER="google-chrome.desktop"
if [[ $(uname -m) == "aarch64" ]]; then
    for desktop in chromium_chromium.desktop chromium.desktop chromium-browser.desktop; do
        if [[ -e /usr/share/applications/$desktop || -e /var/lib/snapd/desktop/applications/$desktop ]]; then
            BROWSER="$desktop"
            break
        fi
    done
fi

gsettings set org.gnome.shell favorite-apps "['$BROWSER', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'cyberchef.desktop', 'burpsuite.desktop', 'cutter.desktop', 'ghidra.desktop', 'networkminer.desktop', 'org.wireshark.Wireshark.desktop']"
