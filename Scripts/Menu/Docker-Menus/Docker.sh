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
           1 "Database Dockers (Menu)" \
           2 "Monitoring Dockers (Menu)" \
           3 "Self-Hosting LAN Based Dockers (Menu)" \
           4 "Self-Hosting Domain Based Dockers (Menu)" \
           5 "Docker-CnC Scripts (Menu)" \
           6 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER_MENU_DATABASE
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER_MENU_MONITORING
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER_MENU_LAN_BASED
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER_MENU_DOMAIN_BASED
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER_CNC
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
