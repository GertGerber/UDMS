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

# Use dialog to create a more user-friendly menu
function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Update All ACS Dockers (Script)" \
           2 "Update Frontend ACS Dockers (Script)" \
           3 "Update Only Movie Node ACS Dockers (Script)" \
           4 "Update Only Show Node ACS Dockers (Script)" \
           5 "Update Only Plex ACS Dockers (Script)" \
           7 "Back To ACS Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$DOCKER_UPDATE
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$DOCKER_UPDATE_FRONTEND
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$DOCKER_UPDATE_MOVIE
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$DOCKER_UPDATE_SHOW
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$RRH_SOFTWARE_FOLDER/$ACS_FOLDER/$ACS_SCRIPT_FOLDER/$DOCKER_UPDATE_PLEX_ONLY
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