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

script_name=$(basename "$0" .sh)

# Use dialog to create a more user-friendly menu
function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "News Report Docker Installer (Script)" \
           2 "Run the EWD Installer (Script)" \
           3 "Setup Alias Pre-Config (Script)" \
           4 "Host Information System (Script)" \
           5 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash <(wget -qO- https://raw.githubusercontent.com/GertGerber/NRD/Production/Setup.sh)
            ;;
        2)
            bash <(wget -qO- https://raw.githubusercontent.com/GertGerber/EWD/Production/Setup.sh)
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ALIAS_PRE_CONFIG
            ;;
        4) 
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$HOST_INFO_SYSTEM_FOLDER/$HOST_INFO_COLLECTER
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

