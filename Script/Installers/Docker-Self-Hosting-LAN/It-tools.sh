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

clear 

echo -e "${Green}Setup a Docker container for It-tools${NC}"

echo -e "${Yellow}Do you want to learn more about how to set it up? (Y/N)${NC}"
read -p "Enter your choice: " decision

if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
    echo -e "${Yellow}Set up instructions: $IT_TOOLS_HELPLINK${NC}"
elif [ "$decision" == "N" ] || [ "$decision" == "n" ]; then
    echo -e "${Blue}Skipping setup instructions.${NC}"
fi

# Prompt user for container name
read -p "Enter the name for the container (default: it-tools): " CONTAINER_NAME
CONTAINER_NAME=${CONTAINER_NAME:-"it-tools"}

# Prompt user for restart policy
read -p "Enter the restart policy for the container (default: unless-stopped): " RESTART_POLICY
RESTART_POLICY=${RESTART_POLICY:-"unless-stopped"}

# Prompt user for ports mapping
read -p "Enter the port mapping for the container (default: 8080:80): " PORT_MAPPING
PORT_MAPPING=${PORT:-"8080"}

# Check if the port is already in use by docker
if [[ $(sudo docker ps -a -q -f "publish=$PORT" | wc -l) -gt 0 ]]; then
    echo -e "${Red}The port $PORT is already in use by another Docker container.${NC}"
    read -p "Enter a different port: " PORT
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  --restart "$RESTART_POLICY" \
  -p "$PORT:80" \
  corentinth/it-tools:latest

# Check if the Docker container has started successfully
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    dialog --title "Success" --msgbox "The Docker container $CONTAINER_NAME has started successfully." 6 60
else
    dialog --title "Error" --msgbox "Failed to start the Docker container $CONTAINER_NAME. Please check the logs for details." 6 60
    exit 1
fi