#!/bin/bash

#   /UDMS/Scripts/UDMS-install/Pre-Release-Downloads.sh
#-----------------------------------------------------------------------------------#
#
#   MADE AND MAINTAINED BY GertGerber
#   https://github.com/GertGerber
#
#   MADE BY @GertGerber   
#   https://github.com/GertGerber  https://rp-helpdesk.com
#
#-----------------------------------------------------------------------------------#
##########################################################################
#####  Set variables for UDMS  # Core.sh # Made for @GertGerber #####
########################## Made for @GertGerber #############################
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

# Get the release version as user input
echo -e "${Green}Enter the release version you want to download (e.g. v1.2.3): ${NC}"
read -r latest_release

# Check that the user has input something
if [ -z "$latest_release" ]; then
    echo -e "${Red}You did not enter a release version.${NC}"
    echo -e "${Red}Exiting script.${NC}"
    exit 1
fi

# Download the latest release
wget -c -q "https://github.com/GertGerber/UDMS/archive/refs/tags/$latest_release.tar.gz"


sleep 5 

# Extract the archive
tar -xzf "$latest_release.tar.gz"

sleep 2
# Remove 'v' from the beginning of the release version
latest_release="${latest_release#v}"

# Rename the unpacked directory to UDMS
mv "UDMS-$latest_release" ~/UDMS
latest_release="v$latest_release"

# Clean up
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
# Remove the downloaded archive
if [ -f "$latest_release.tar.gz" ]; then
    rm "$latest_release.tar.gz"
fi
if [ -d ~/UDMS/$GITHUB_FOLDER ]; then
    rm -r ~/UDMS/$GITHUB_FOLDER
fi
if [ -d ~/UDMS/$DOCS_FOLDER ]; then
    rm -r ~/UDMS/$DOCS_FOLDER
fi
if [ -f ~/UDMS/$README_FILE ]; then
    rm ~/UDMS/$README_FILE
fi
if [ -f ~/UDMS/$MKDOCS_FILE ]; then
    rm ~/UDMS/$MKDOCS_FILE
fi
if [ -f ~/UDMS/$SECURITY_FILE ]; then
    rm ~/UDMS/$SECURITY_FILE
fi
if [ -f ~/UDMS/$CODE_OF_CONDUCT_FILE ]; then
    rm ~/UDMS/$CODE_OF_CONDUCT_FILE
fi
if [ -f ~/UDMS/$CONTRIBUTING_FILE ]; then
    rm ~/UDMS/$CONTRIBUTING_FILE
fi
if [ -d ~/old_UDMS_logs ]; then
    rm -r ~/old_UDMS_logs
fi
sleep 2

# Update the locally stored release version
echo "$latest_release" > ~/UDMS/.latest_release.txt

echo -e "${Yellow}Unpacked${NC} ${Green}and${NC} ${Yellow}renamed${NC} ${Green}to${NC} ${Yellow}UDMS${NC}"
echo 
echo 
echo -e "${Green}Description of the latest release (${NC}${Yellow}$latest_release${NC}${Green})${NC}${Green}:${NC}"
echo -e "${LightRed}We read every piece of feedback, and take your input very seriously.${NC}"
echo -e "${Green}Full Changelog:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/commits/${NC}${Yellow}$latest_release${NC}"
echo -e "${Green}Release Notes:${NC} ${BrownOrange}https://github.com/GertGerber/UDMS/releases/tag/${NC}${Yellow}$latest_release${NC}"
echo

bash ~/UDMS/Script/UDMS-Install/Setup.sh