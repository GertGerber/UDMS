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
           1 "Run the Tailscale Installer (Script)" \
           2 "Run the Starship Installer (Script)" \
           3 "Run the Filezilla Installer (Script)" \
           4 "Run the Fail2Ban Installer (Script)" \
           5 "Run the Ansible Installer (Script)" \
           6 "Run the Pydio Installer (Script)" \
           7 "Back To Main Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$TAILSCALE
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$STARSHIP
            sleep 1
            source ~/.bashrc
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$FILEZILLA
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$FAIL2BAN
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$ANSIBLE
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$QUICK_INSTALLERS_DIR/$PYDIO
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

