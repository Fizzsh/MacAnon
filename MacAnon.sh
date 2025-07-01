#!/bin/bash

echo ' __  __               _                      '
echo '|  \/  | __ _  ___   / \   _ __   ___  _ __  '
echo '| |\/| |/ _` |/ __| / _ \ | '\''_ \ / _ \| '\''_ \ '
echo '| |  | | (_| | (__ / ___ \| | | | (_) | | | |'
echo '|_|  |_|\__,_|\___/_/   \_\_| |_|\___/|_| |_| ~ @Fizzsh'
sleep 1
echo "(This script will disconnect your connection for 1-10 seconds to work.)"
sleep 2
echo

# Check for macchanger
if ! command -v macchanger >/dev/null 2>&1; then
    echo "macchanger is not installed."
    echo "Install it with one of the following based on your distro:"
    echo "  Debian/Ubuntu/Kali: sudo apt install macchanger"
    echo "  Arch/Manjaro:        sudo pacman -S macchanger"
    echo "  Fedora:              sudo dnf install macchanger"
    echo "  openSUSE:            sudo zypper install macchanger"
    exit 1
fi

# Check active adapters
echo "Active network interfaces:"
ip -o link show up | awk -F': ' '{print $2}'
echo
sleep 2

# Ask for adapter name
while true; do
    read -p "Enter your network adapter name (e.g., wlan0, eth0): " adapter

    # Check if adapter exists
    if ip link show "$adapter" > /dev/null 2>&1; then
        break
    else
        echo "X '$adapter' is not a valid or active adapter. Please try again."
    fi
done
echo


# Check for NetworkManager
if command -v nmcli >/dev/null 2>&1; then
    echo "[*] Detected NetworkManager. Disconnecting $adapter..."
    nmcli device set "$adapter" managed no
fi

echo "Checking current address for $adapter..."
sleep 1
sudo macchanger -s "$adapter"
echo

sleep 1
echo "Randomizing MAC Address..."
sleep 2
sudo ip link set "$adapter" down
sudo macchanger -r "$adapter"
sudo ip link set "$adapter" up
echo

# Reconnect if NetworkManager is present
if command -v nmcli >/dev/null 2>&1; then
    echo "[*] Reconnecting $adapter via NetworkManager..."
    nmcli device set "$adapter" managed yes
    nmcli device connect "$adapter" >/dev/null 2>&1
fi

sleep 1
echo "Waiting a few seconds for NetworkManager to stabilize..."
sleep 5  # Wait 5 seconds to let NM settle

echo "Validating progress..."
sudo macchanger -s "$adapter"
echo

sleep 1
echo "Your MAC Address is now randomized!"
echo "If in doubt, run: sudo macchanger -s $adapter"
