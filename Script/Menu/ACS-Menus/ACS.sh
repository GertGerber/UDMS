#!/bin/bash
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
source ~/UDMS/Core/ACS-Core.sh

script_name=$(basename "$0" .sh)

if [ ! -d "$HOME/ACS-Dockers" ]; then
    chmod +x ~/UDMS/Script/RRH-Software/ACS/setup.sh
    bash ~/UDMS/Script/RRH-Software/ACS/setup.sh
    exit 1
fi

# Use dialog to create a more user-friendly menu
function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Youtube Download Scripts (Menu)" \
           2 "Start All ACS Dockers (Command Script)" \
           3 "Stop All ACS Dockers (Command Script)" \
           4 "Stop and Remove All ACS Dockers (Command Script)" \
           5 "Uninstall ACS (Command Script)" \
           6 "Usage (Command Script)" \
           7 "Update All ACS Dockers (Menu)" \
           8 "Automate The Update of All ACS Dockers (Menu)" \
           9 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$ACS_MENUS_FOLDER/$YOUTUBE_SCRIPTS
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$START
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$STOP
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$STOP_REMOVE
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$UNINSTALL
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$USAGE
            ;;
        7)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$ACS_MENUS_FOLDER/$ACS_UPDATE_MENU
            ;;
        8)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$ACS_MENUS_FOLDER/$ACS_AUTOMATED_UPDATE_MENU
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