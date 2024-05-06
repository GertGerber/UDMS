##!/bin/bash
#-----------------------------------------------------------------------------------#
#
#   MADE AND MAINTAINED BY GertGerber
#   https://github.com/GertGerber
#
#   MADE BY @GertGerber   
#   https://github.com/GertGerber  https://rp-helpdesk.com
#
#-----------------------------------------------------------------------------------#
## TO-DO-LIST
#
# 1. 
# 2.
# 3.
# 4. 
#
#-----------------------------------------------------------------------------------#

clear 
source ~/UDMS/Core/Core.sh

script_name=$(basename "$0" .sh)

# Use dialog to create a more user-friendly menu
function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Run the llama-gpt Installer (Installation Script)" \
           2 "Run Portainer Installer (Installation Script)" \
           3 "Run Deluge Installer (Installation Script)" \
           4 "Run It-tools Installer (Installation Script)" \
           5 "Run Sonarr Installer (Installation Script)" \
           6 "Run Radarr Installer (Installation Script)" \
           7 "Run Jackett Installer (Installation Script)" \
           8 "Run Docker Registry Installer (Installation Script)" \
           9 "Run Jenkins Installer (Installation Script)" \
           10 "Back To Docker Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$LLAMA_GPT
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$PORTAINER
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$DELUGE
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$IT_TOOLS
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$SONARR
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$RADARR
            ;;
        7)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$JACKETT
            ;;
        8)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$DOCKER_REGISTRY
            ;;
        9)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_LAN/$JENKINS
            ;;
        *)
            exit 0
            ;;
    esac
}

# Define the input file for dialog selections
INPUT=/tmp/menu.sh.$$

# Ensure the temp file is removed upon script termination
trap "rm -f $INPUT" 0 1 2 5 15

# Main loop
while true; do
    show_dialog_menu
done
