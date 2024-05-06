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
           1 "Run Vaultwarden Installer (Installation Script)" \
           2 "Run Cloudflare Tunnel Installer (Installation Script)" \
           3 "Run MediaCMS Installer (Installation Script)" \
           4 "Run NTFY Installer (Installation Script)" \
           5 "Run N8N Installer (Installation Script)" \
           6 "Run Ghost Installer (Installation Script)" \
           7 "Run Linkwarden Installer (Installation Script)" \
           8 "Run Memos Installer (Installation Script)" \
           9 "Run Ombi Installer (Installation Script)" \
           10 "Run Gitea Installer (Installation Script)" \
           11 "Back To Docker Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$VAULTWARDEN
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$CLOUDFLARE_TUNNEL
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$MEDIACMS
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$NTFY
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$N8N
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$GHOST
            ;;
        7)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$LINKWARDEN
            ;;
        8)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$MEMOS
            ;;
        9)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$OMBI
            ;;
        10) 
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$INSTALLER_FOLDER/$DOCKER_SELF_HOSTING_FOLDER_DOMAIN/$GITEA
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
