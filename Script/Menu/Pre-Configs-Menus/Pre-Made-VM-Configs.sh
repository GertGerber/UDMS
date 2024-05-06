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

source ~/UDMS/Core/Core.sh

clear

script_name=$(basename "$0" .sh)

function show_dialog_menu() {
    dialog --clear
    dialog --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Run the RP-Helpdesk Standard Config (Script)" \
           2 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")

    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$PRE_MADE_VM_CONFIGS_DIR/$PRE_MADE_VM
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