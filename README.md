# MacAnon
A simple Bash script to randomize your MAC address for enhanced privacy.
![macanon](https://github.com/user-attachments/assets/b0133004-4992-4444-8603-613d24f67c2c)

# This tool requires 'macchanger'. For this to work, make sure to install it for your specific Linux distro with the installation guide below:

# Debian/Ubuntu/Kali
`sudo apt install macchanger`

# Arch/Manjaro
`sudo pacman -S macchanger`

# Fedora
`sudo dnf install macchanger`

# openSUSE
`sudo zypper install macchanger`

# Tool Installation
`git clone https://github.com/Fizzsh/MacAnon.git`

`cd macanon.sh`

`chmod +x macanon.sh`

# Usage
`bash macanon.sh`



#❗Warning

    This script temporarily disconnects your network interface. Do not run it during sensitive operations or downloads.
    May not work properly on virtual machines with limited adapter control or systems using custom network managers.
    Exiting the script without going through the process will temporarily turn off your NetworkManager, to restore your adapter and regain a connection, use;
    `sudo rfkill unblock all`

If there are any issues, please feel free to open an issue and I'll try my best to help out! :)
