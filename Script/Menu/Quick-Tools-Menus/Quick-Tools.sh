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
           1 "Update Software Via deb Files (Script)" \
           2 "ACS Cleanup (Script)" \
           3 "UDMS MOTD (Script)" \
           4 "SSH Key Setup + Push Keys to Remote Host (Script)" \
           5 "SSH Push to Remote host" \
           6 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_TOOLS_DIR/$MANUALLY_INSTALL_SOFTWARE_UPDATE
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_TOOLS_DIR/$DISK_CLEANUP
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_TOOLS_DIR/$MOTD_UDMS
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_TOOLS_DIR/$SSH_KEY_SETUP
            ;;
        5) 
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_TOOLS_DIR/$SSH_KEY_PUSH
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
