#!/bin/bash
#-----------------------------------------------------------------------------------#
#
#   MADE AND MAINTAINED BY GertGerber
#   https://github.com/GertGerber
#
#   MADE BY @gertgerber  
#   https://github.com/gertgerber  https://rp-helpdesk.com
#
#-----------------------------------------------------------------------------------#
##########################################################################
#####  Set variables for UDMS  # Core.sh # Made for @GertGerber #####
########################## Made for @rune004 #############################
##########################################################################
##### Styles ######
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
BrownOrange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m'
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'
White='\e[1;37m'
NC='\e[0m'  # Reset to default
############################################################################


## Folders to clean up after installation
GITHUB_FOLDER=.github
DOCS_FOLDER=docs

## Files to clean up after installation
README_FILE=README.md
MKDOCS_FILE=mkdocs.yml
SECURITY_FILE=SECURITY.md
CODE_OF_CONDUCT_FILE=CODE_OF_CONDUCT.md
CONTRIBUTING_FILE=CONTRIBUTING.md

echo -e "${Green}Downloading the latest updates for the dependencies...${NC}"

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    sudo apt-get update  
    sudo apt-get upgrade -y  
    else 
    apt-get update  
    apt-get upgrade -y  
fi

echo -e "${Green}Dependencies have been successfully updated.${NC}"

# Check if the UDMS-Install folder already exists
if [ -d ~/UDMS-install ]; then
    echo -e "${Red}The UDMS-install folder already exists.${NC}" 
    read -p "The UDMS-install folder already exists. Would you like to remove it and continue the download? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${Green}Moving the logs folder to ~/old_UDMS-install_logs...${NC}"
        if [ -d ~/UDMS-install/logs ]; then
            mv ~/UDMS-install/logs ~/old_UDMS-install_logs
        else
            echo -e "${Yellow}~/UDMS-install/logs does not exist, skipping...${NC}"
        fi
        sleep 2
        echo -e "${Green}Removing the UDMS-install folder...${NC}"
        rm -r UDMS-install
    else
        echo -e "${Red}Exiting script.${NC}"
        exit 1
    fi
fi

if ! dpkg -s sudo &> /dev/null; then
    echo -e "${Red}sudo is not installed.${NC} ${Yellow}Installing sudo...${NC}"
    if [ "$EUID" -ne 0 ]; then
    sudo apt-get install sudo  
    else 
    apt-get install sudo  
    fi
    echo -e "${Green}sudo has been successfully installed.${NC}"
fi

if ! dpkg -s curl &> /dev/null; then
    echo -e "${Red}curl is not installed.${NC} ${Yellow}Installing curl...${NC}"
    if [ "$EUID" -ne 0 ]; then
    sudo apt-get install -y curl  
    else 
    apt-get install -y curl  
    fi
    echo -e "${Green}curl has been successfully installed.${NC}"
fi

# GitHub repository URL
REPO_URL="https://github.com/GertGerber/UDMS/releases/latest"

# Fetch the latest release version from GitHub
latest_release=$(curl -sSLI -o /dev/null -w %{url_effective} "$REPO_URL" | awk -F '/' '{print $NF}')


# Download the latest release
wget -c -q "https://github.com/GertGerber/UDMS/archive/refs/tags/$latest_release.tar.gz"

# Extract the archive
tar -xzf "$latest_release.tar.gz"

sleep 2
# Remove 'v' from the beginning of the release version
latest_release="${latest_release#v}"

# Rename the unpacked directory to UDMS-install
mv "UDMS-install-$latest_release" ~/UDMS-install
latest_release="v$latest_release"

# Clean up
echo -e "${Green}Cleaning up...${NC}"
echo -e "${Green}Moving the logs folder to ~/UDMS-install/logs/old_UDMS-install_logs ...${NC}"
if [ -d ~/old_UDMS-install_logs ]; then 
    sleep 2
    mkdir -p ~/UDMS-install/logs
    mv ~/old_UDMS-install_logs ~/UDMS-install/logs/
else
    echo -e "${Yellow}~/old_UDMS-install_logs does not exist, skipping...${NC}"
fi
sleep 2
# Remove the downloaded archive
if [ -f "$latest_release.tar.gz" ]; then
    rm "$latest_release.tar.gz"
fi
if [ -d ~/UDMS-install/$GITHUB_FOLDER ]; then
    rm -r ~/UDMS-install/$GITHUB_FOLDER
fi
if [ -d ~/UDMS-install/$DOCS_FOLDER ]; then
    rm -r ~/UDMS-install/$DOCS_FOLDER
fi
if [ -f ~/UDMS-install/$README_FILE ]; then
    rm ~/UDMS-install/$README_FILE
fi
if [ -f ~/UDMS-install/$MKDOCS_FILE ]; then
    rm ~/UDMS-install/$MKDOCS_FILE
fi
if [ -f ~/UDMS-install/$SECURITY_FILE ]; then
    rm ~/UDMS-install/$SECURITY_FILE
fi
if [ -f ~/UDMS-install/$CODE_OF_CONDUCT_FILE ]; then
    rm ~/UDMS-install/$CODE_OF_CONDUCT_FILE
fi
if [ -f ~/UDMS-install/$CONTRIBUTING_FILE ]; then
    rm ~/UDMS-install/$CONTRIBUTING_FILE
fi
if [ -d ~/old_UDMS-install_logs ]; then
    rm -r ~/old_UDMS-install_logs
fi
sleep 2

# Update the locally stored release version
echo "$latest_release" > ~/UDMS-install/.latest_release.txt

echo -e "${Yellow}Unpacked${NC} ${Green}and${NC} ${Yellow}renamed${NC} ${Green}to${NC} ${Yellow}UDMS-install${NC}"
echo 
echo 
echo -e "${Green}Description of the latest release (${NC}${Yellow}$latest_release${NC}${Green})${NC}${Green}:${NC}"
echo -e "${LightRed}We read every piece of feedback, and take your input very seriously.${NC}"
echo -e "${Green}Full Changelog:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/commits/${NC}${Yellow}$latest_release${NC}"
echo -e "${Green}Release Notes:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/releases/tag/${NC}${Yellow}$latest_release${NC}"
echo

bash ~/UDMS-install/Script/UDMS-Install/Setup.sh