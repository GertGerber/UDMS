#!/bin/bash


#-----------------------------------------------------------------------------------#

# Title: /UDMS/Scripts/UDMS-install/Downloads.sh
# Author: GertGerber
# Repository: https://github.com/GertGerber
# Description: This script automates the installation process of UDMS (Unified Device Management System).
#-----------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------#
# SECTION 1:  Set Variables
#-----------------------------------------------------------------------------------#

# Styles
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

## Folders to clean up after installation
GITHUB_FOLDER=.github
DOCS_FOLDER=docs

## Files to clean up after installation
README_FILE=README.md
MKDOCS_FILE=mkdocs.yml
SECURITY_FILE=SECURITY.md
CODE_OF_CONDUCT_FILE=CODE_OF_CONDUCT.md
CONTRIBUTING_FILE=CONTRIBUTING.md

#-----------------------------------------------------------------------------------#
# SECTION 2:  Update Dependencies
#-----------------------------------------------------------------------------------#

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

#-----------------------------------------------------------------------------------#
# SECTION 2:  Check Existing Installation
#-----------------------------------------------------------------------------------#

# Check if the UDMS folder already exists
if [ -d ~/UDMS ]; then
    echo -e "${Red}The UDMS folder already exists.${NC}" 
    read -p "The UDMS folder already exists. Would you like to remove it and continue the download? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${Green}Moving the logs folder to ~/old_UDMS_logs...${NC}"
        if [ -d ~/UDMS/logs ]; then
            mv ~/UDMS/logs ~/old_UDMS_logs
        else
            echo -e "${Yellow}~/UDMS/logs does not exist, skipping...${NC}"
        fi
        sleep 2
        echo -e "${Green}Removing the UDMS folder...${NC}"
        rm -r UDMS
    else
        echo -e "${Red}Exiting script.${NC}"
        exit 1
    fi
fi

#-----------------------------------------------------------------------------------#
# SECTION 3:  Install Dependencies
#-----------------------------------------------------------------------------------#

# Check and install sudo if not installed
if ! dpkg -s sudo &> /dev/null; then
    echo -e "${Red}sudo is not installed.${NC} ${Yellow}Installing sudo...${NC}"
    if [ "$EUID" -ne 0 ]; then
    sudo apt-get install sudo  
    else 
    apt-get install sudo  
    fi
    echo -e "${Green}sudo has been successfully installed.${NC}"
fi

# Check and install curl if not installed
if ! dpkg -s curl &> /dev/null; then
    echo -e "${Red}curl is not installed.${NC} ${Yellow}Installing curl...${NC}"
    if [ "$EUID" -ne 0 ]; then
    sudo apt-get install -y curl  
    else 
    apt-get install -y curl  
    fi
    echo -e "${Green}curl has been successfully installed.${NC}"
fi

#-----------------------------------------------------------------------------------#
# SECTION 4:  Download and Extract Latest Release
#-----------------------------------------------------------------------------------#

# GitHub repository URL
REPO_URL="https://github.com/GertGerber/UDMS/releases/latest"

# Fetch the latest release version from GitHub
latest_release=$(curl -sSLI -o /dev/null -w %{url_effective} "$REPO_URL" | awk -F '/' '{print $NF}')


# Download the latest release
wget -c -q "https://github.com/GertGerber/UDMS/archive/refs/tags/$latest_release.tar.gz"

sleep 2 

# Extract the archive
tar -xzf "$latest_release.tar.gz"

sleep 2

# Remove 'v' from the beginning of the release version
latest_release="${latest_release#v}"

# Rename the unpacked directory to UDMS
mv "UDMS-$latest_release" ~/UDMS
latest_release="v$latest_release"

#-----------------------------------------------------------------------------------#
# SECTION 5:  Clean Up
#-----------------------------------------------------------------------------------#

echo -e "${Green}Cleaning up...${NC}"
echo -e "${Green}Moving the logs folder to ~/UDMS/logs/old_UDMS_logs ...${NC}"
if [ -d ~/old_UDMS_logs ]; then 
    sleep 2
    mkdir -p ~/UDMS/logs
    mv ~/old_UDMS_logs ~/UDMS/logs/
else
    echo -e "${Yellow}~/old_UDMS_logs does not exist, skipping...${NC}"
fi
sleep 2

# Remove the downloaded archive and unnecessary files
if [ -f "$latest_release.tar.gz" ]; then
    rm "$latest_release.tar.gz"
fi

rm -rf ~/UDMS/.github
rm -rf ~/UDMS/docs
rm -f ~/UDMS/README.md
rm -f ~/UDMS/mkdocs.yml
rm -f ~/UDMS/SECURITY.md
rm -f ~/UDMS/CODE_OF_CONDUCT.md
rm -f ~/UDMS/CONTRIBUTING.md

if [ -d ~/old_UDMS_logs ]; then
    rm -rf ~/old_UDMS_logs
fi
sleep 2

# Update the locally stored release version
echo "$latest_release" > ~/UDMS/.latest_release.txt

#-----------------------------------------------------------------------------------#
# SECTION 6:  Display Information
#-----------------------------------------------------------------------------------#

echo -e "${Yellow}Unpacked${NC} ${Green}and${NC} ${Yellow}renamed${NC} ${Green}to${NC} ${Yellow}UDMS${NC}"
echo 
echo 
echo -e "${Green}Description of the latest release (${NC}${Yellow}$latest_release${NC}${Green})${NC}${Green}:${NC}"
echo -e "${LightRed}We read every piece of feedback, and take your input very seriously.${NC}"
echo -e "${Green}Full Changelog:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/commits/${NC}${Yellow}$latest_release${NC}"
echo -e "${Green}Release Notes:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/releases/tag/${NC}${Yellow}$latest_release${NC}"
echo

#-----------------------------------------------------------------------------------#
# SECTION 7:  Run Setup Script
#-----------------------------------------------------------------------------------#

bash ~/UDMS/Script/UDMS-Install/Setup.sh
