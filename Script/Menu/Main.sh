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


#-----------------------------------------------------------------------------------#
# SECTION 1: Initial Setup
#-----------------------------------------------------------------------------------#

# Get hostname and IP address
hostname=$(hostname)
ip=$(hostname -I | cut -d' ' -f1)

# Clear the screen
clear 

# Source Core.sh script
source ~/UDMS/Core/Core.sh

# Set script name
script_name=$(basename "$0" .sh)

# Define input file for dialog selections
INPUT=/tmp/menu.sh.$$

# Ensure the temp file is removed upon script termination
trap "rm -f $INPUT" 0 1 2 5 15

#-----------------------------------------------------------------------------------#
# SECTION 2: Define Menu Function
#-----------------------------------------------------------------------------------#

function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Docker Menu" \
           2 "GertGerber Software Menu" \
           3 "Quick Installer Menu" \
           4 "Cronjobs Menu" \
           5 "Quick Tools Menu" \
           6 "Pre-Made VM Configurations Menu" \
           7 "ACS Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER_MENUS_FOLDER/$DOCKER"
            ;;
        2)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$RRH_SOFTWARE_MENU_FOLDER/$RRH_SOFTWARE"
            ;;
        3)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$QUICK_INSTALLERS_MENUS_FOLDER/$QUICK_INSTALLERS"
            ;;
        4)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$CRONJOB_MENUS_FOLDER/$CRONJOB"
            ;;
        5)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$QUICK_TOOLS_MENUS_FOLDER/$QUICK_TOOLS"
            ;;
        6)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$PRE_CONFIGS_MENUS_FOLDER/$PRE_MADE_VM_CONFIGS"
            ;;
        7)
            bash "$ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$ACS_MENUS_FOLDER/$ACS_MENU"
            ;;
        *)
            dialog --title "Exiting" --msgbox "Thank you for using UDMS. Support me via github https://github.com/GertGerber/" 6 52
            clear
            exit 0
            ;;
    esac
}

#-----------------------------------------------------------------------------------#
# SECTION 3: Main Execution Loop
#-----------------------------------------------------------------------------------#

# Main loop
while true; do
    show_dialog_menu
done
