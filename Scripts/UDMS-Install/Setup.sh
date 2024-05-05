#!/bin/bash
#-----------------------------------------------------------------------------------#
#
#   MADE AND MAINTAINED BY RUNESREPOHUB
#   https://github.com/RunesRepoHub
#
#   MADE BY @rune004   
#   https://github.com/rune004  https://rp-helpdesk.com
#
#-----------------------------------------------------------------------------------#
# Detect the distribution name from /etc/os-release
OS_DISTRO=$(grep '^NAME=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')

# Kali Linux specific Docker CE installation
if [ "$OS_DISTRO" = "Kali GNU/Linux" ]; then
    echo "Detected Kali Linux. Installing Docker CE..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable docker --now
    echo "Docker CE has been installed and started on Kali Linux."
fi

if [ "$OS_DISTRO" != "Kali GNU/Linux" ]; then
    # Check if Docker is installed and install it if not
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Attempting to install Docker..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        if ! command -v docker &> /dev/null; then
            echo "Failed to install Docker. Aborting script."
            exit 1
        fi
        echo "Docker has been successfully installed."
    fi
fi

# Function to safely execute commands with sudo if not running as root
execute() {
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}

# Install dialog package if not already installed
execute apt-get install dialog -y > /dev/null 2>&1

# Create or overwrite the .dialogrc configuration file in the user's home directory
execute cp ~/RRHQD/Script/RRHQD-Install/dialog.txt "${HOME}/.dialogrc"


# Detect the distribution name from /etc/os-release
OS_DISTRO=$(grep '^NAME=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')

# Only run the block if the OS_DISTRO is not Kali GNU/Linux
if [ "$OS_DISTRO" != "Kali GNU/Linux" ]; then
    # Check if the alias 'qd' already exists in .bashrc
    if grep -q "alias qd=" ~/.bashrc; then
        echo "The alias 'qd' already exists. Would you like to pick a new alias name? (yes/no)"
        read -p "Enter yes or no: " user_choice
        if [[ $user_choice == "yes" ]]; then
            echo "Please enter a new alias name:"
            read -p "New alias name: " new_alias
            # Add the new alias to .bashrc
            echo "alias $new_alias=\"bash ~/RRHQD/Script/Menu/Main.sh\"" >> ~/.bashrc
        fi
    else
        # Add the alias 'qd' to .bashrc
        echo "alias qd=\"bash ~/RRHQD/Script/Menu/Main.sh\"" >> ~/.bashrc
    fi
    # Check if the alias 'qd-update' already exists in .bashrc
    if grep -q "qd-update" ~/.bashrc; then
        :
    else
        echo "alias qd-update=\"bash ~/RRHQD/Script/RRHQD-Install/Download.sh\"" >> ~/.bashrc
    fi
    # Check if the alias 'qd-update' already exists in .bashrc
    if grep -q "qd-update-dev" ~/.bashrc; then
        :
    else
        echo "alias qd-update-dev=\"bash ~/RRHQD/Script/RRHQD-Install/Pre-Release-Download.sh\"" >> ~/.bashrc
    fi
fi



# Only run the block if the OS_DISTRO is Kali GNU/Linux
if [ "$OS_DISTRO" = "Kali GNU/Linux" ]; then
    # Check if the alias 'qd' already exists in .zshrc
    if grep -q "alias qd=" ~/.zshrc; then
        # Ask the user if they want to overwrite the existing alias
        echo "The alias 'qd' already exists. Would you like to pick a new alias name? (yes/no)"
        read -p "Enter yes or no: " user_choice
        if [[ $user_choice == "yes" ]]; then
            echo "Please enter a new alias name:"
            read -p "New alias name: " new_alias
            # Add the new alias to .zshrc
            echo "alias $new_alias=\"bash ~/RRHQD/Script/Menu/Main.sh\"" >> ~/.zshrc
        fi
    else
        # Ensure .zshrc exists and has the correct permissions
        if [ ! -f ~/.zshrc ]; then
            touch ~/.zshrc
            chmod 644 ~/.zshrc
        fi
        echo "Adding alias 'qd' to .zshrc"
        echo "alias qd='bash ~/RRHQD/Script/Menu/Main.sh'" >> ~/.zshrc
    fi
    # Check if the alias 'qd-update' already exists in .zshrc
    if grep -q "qd-update" ~/.zshrc; then
        :
    else
        echo "alias qd-update=\"bash ~/RRHQD/Script/RRHQD-Install/Download.sh\"" >> ~/.zshrc
    fi
    # Check if the alias 'qd-update' already exists in .zshrc
    if grep -q "qd-update-dev" ~/.zshrc; then
        :
    else
        echo "alias qd-update-dev=\"bash ~/RRHQD/Script/RRHQD-Install/Pre-Release-Download.sh\"" >> ~/.zshrc
    fi
fi


if [ "$OS_DISTRO" != "Kali GNU/Linux" ]; then
    # Source the .bashrc to make the new alias available
    if [ -f ~/.bashrc ]; then
        source ~/.bashrc
    fi
fi


if [ "$OS_DISTRO" = "Kali GNU/Linux" ]; then
    # Source the .zshrc to make the new alias available
    if [ -f ~/.zshrc ]; then
        source ~/.zshrc
    fi
fi

if [ "$OS_DISTRO" != "Kali GNU/Linux" ]; then
    if [ -f ~/get-docker.sh ]; then
        rm ~/get-docker.sh
    fi
fi

sleep 3

bash ~/RRHQD/Script/Menu/Main.sh


