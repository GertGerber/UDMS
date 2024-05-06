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

function show_dialog_menu() {
    dialog --clear \
           --backtitle "$PROJECT_NAME" \
           --title "$script_name - Menu" \
           --menu "Please select a $script_name script to run:" 30 90 4 \
           1 "Download YouTube Playlist (Script)" \
           2 "Download Fully Youtube Channel (Script)" \
           3 "Rescan Youtube Channel Downloads For New Videos (Script)" \
           4 "Download Playlist MP3 (Script)" \
           5 "Stop all Youtube Downlaods (Script)" \
           6 "Rescan urls Every 20 mins (Script)" \
           7 "Convert Webp to JPEG (Script)" \
           8 "Back To ACS Menu" 2>"${INPUT}"

    menu_choice=$(<"${INPUT}")
    case $menu_choice in
        1)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_DOWNLOAD
            ;;
        2)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_CHANNEL_DOWNLOAD
            ;;
        3)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_CHANNEL_AUTO
            ;;
        4)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_AUDIO_PLAYLIST
            ;;
        5)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_STOP_DOWNLOAD
            ;;
        6)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$YOUTUBE_CRONJOB_DOWNLOAD
            ;;
        7)
            bash $ROOT_FOLDER/$SCRIPT_FOLDER/$YOUTUBE_SCRIPTS_FOLDER/$WEBP_TO_JPEG_MANUEL
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
