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
           1 "Docker - Cleanup (Command Script)" \
           2 "Docker - Start (Command Script)" \
           3 "Docker - Stop (Command Script)" \
           4 "Docker - Update (Command Script)" \
           5 "Docker - Reset (Command Script)" \
           6 "Docker - Remove (Command Script)" \
           7 "Back To Docker Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_CLEANUP
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_START
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_STOP
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_UPDATE
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_RESET
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$DOCKER_CNC_FOLDER/$DOCKER_REMOVE
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

