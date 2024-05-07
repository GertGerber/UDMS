#!/bin/bash
#-----------------------------------------------------------------------------------#
#
#   MADE AND MAINTAINED BY RUNESREPOHUB
#   https://github.com/RunesRepoHub
#
#   MADE BY @rune004   
#   https://github.com/rune004  https://rp-helpdesk.com
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
# LOGGING SYSTEM

SCRIPT_FILENAME=$(basename "$0")

LOG_DIR="$HOME/RRHQD/logs"
# Configuration
LOG_FILE="$LOG_DIR/"$SCRIPT_FILENAME".log"  # Log file location

# Function to increment log file name
increment_log_file_name() {
  local log_file_base_name=""$SCRIPT_FILENAME"_LOG_FILE_"
  local log_file_extension=".log"
  local log_file_counter=1

  while [[ -f "$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}" ]]; do
    ((log_file_counter++))
  done

  LOG_FILE="$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}"
  dialog --clear --backtitle "RRHQD - Log file will be saved as" --title "$SCRIPT_FILENAME" --msgbox "$LOG_FILE" 5 60
}

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Increment log file name for this run
increment_log_file_name

# Redirect all output to the log file
exec > >(tee -a "$LOG_FILE") 2>&1

#-----------------------------------------------------------------------------------#
# SOURCE SYSTEM

## Pick one or both below. Uncomment the one or both you want.

source ~/RRHQD/Core/Core.sh
# source ~/RRHQD/Core/ACS-Core.sh

#-----------------------------------------------------------------------------------#

# Detect OS and set USE_SUDO accordingly
OS_NAME=$(grep '^ID=' /etc/os-release | cut -d= -f2)
USE_SUDO=""
if [[ "$OS_NAME" == "ubuntu" || "$OS_NAME" == "kali" || "$OS_NAME" == "linuxmint" || "$OS_NAME" == "zorin" ]]; then
  USE_SUDO="sudo"
fi

cd
# Script to setup and configure a Llama-GPT.sh Docker container and start it

if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
    echo -e "${Yellow}Set up instructions: $LLAMA_GPT_HELPLINK${NC}"
elif [ "$decision" == "N" ] || [ "$decision" == "n" ]; then
    echo -e "${Blue}Skipping setup instructions.${NC}"
fi


echo -e "${Green}When the script is done, and you see the access via localhost:port, you can just press ctrl+c to exit back to Main Menu${NC}"

cd $ROOT_FOLDER

git clone https://github.com/getumbrel/llama-gpt.git

cd $ROOT_FOLDER/$LLAMA_GPT_FOLDER

$USE_SUDO ./run.sh --model 7b