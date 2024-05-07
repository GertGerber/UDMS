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

cd

echo -e "${Green}Setup a Docker container for Radarr${NC}"

if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
    echo -e "${Yellow}Set up instructions: $RADARR_HELPLINK${NC}"
elif [ "$decision" == "N" ] || [ "$decision" == "n" ]; then
    echo -e "${Blue}Skipping setup instructions.${NC}"
fi

## Ask user for image
echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the Docker image for Radarr (e.g., linuxserver/radarr:latest): " IMAGE
IMAGE=${IMAGE:-"linuxserver/radarr:latest"}

## Ask user for container name
echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the name for the Radarr container: " CONTAINER_NAME
CONTAINER_NAME=${CONTAINER_NAME:-"Radarr"}

## Ask user for port
echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the port to expose Radarr on (e.g., 7878): " PORT
PORT=${PORT:-7878}

# Check if the port is already in use by docker
if [[ $(sudo docker ps -a -q -f "publish=$PORT" | wc -l) -gt 0 ]]; then
    echo -e "${Red}The port $PORT is already in use by another Docker container.${NC}"
    read -p "Enter a different port: " PORT
fi

## Ask user for data path
echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the path for Radarr data (e.g., /radarr-data/): " DATA_PATH
DATA_PATH=${DATA_PATH:-./Data/radarr-data}

# Define the subfolder for the Docker compose files
COMPOSE_SUBFOLDER="$DOCKER_ROOT_FOLDER/$CONTAINER_NAME"
COMPOSE_FILE="$COMPOSE_SUBFOLDER/docker-compose-$CONTAINER_NAME.yml"

# Create the subfolder if it does not exist
mkdir -p "$COMPOSE_SUBFOLDER"

# Create a Docker compose file with the user input inside the subfolder
{
  echo "services:"
  echo "  $CONTAINER_NAME:"
  echo "    image: $IMAGE"
  echo "    container_name: $CONTAINER_NAME"
  echo "    restart: always"
  echo "    ports:"
  echo "      - \"$PORT:7878\""
  echo "    volumes:"
  echo "      - \"$DATA_PATH:/config\""
} > "$COMPOSE_FILE"

# Inform the user where the Docker compose file has been created
echo "Docker compose file created at: $COMPOSE_FILE"

# Inform the user where the Docker compose file has been created
echo "Docker compose file created at: $COMPOSE_FILE"

# Check if Docker is running and use sudo if the OS is ubuntu, zorin, linuxmint, or kali
OS_DISTRO=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
case $OS_DISTRO in
  ubuntu|zorin|linuxmint|kali)
    if ! sudo docker info >/dev/null 2>&1; then
      echo "Docker does not seem to be running, start it first with sudo and then re-run this script."
      exit 1
    fi
    ;;
  *)
    if ! docker info >/dev/null 2>&1; then
      echo "Docker does not seem to be running, start it first and then re-run this script."
      exit 1
    fi
    ;;
esac

# Start the Docker container using docker-compose with or without sudo based on the OS
case $OS_DISTRO in
  ubuntu|zorin|linuxmint|kali)
    sudo docker compose -f "$COMPOSE_FILE" up -d
    ;;
  *)
    docker compose -f "$COMPOSE_FILE" up -d
    ;;
esac

# Check if the Docker container(s) have started successfully
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    dialog --title "Success" --msgbox "The Docker container $CONTAINER_NAME has started successfully." 6 60
else
    dialog --title "Error" --msgbox "Failed to start the Docker container $CONTAINER_NAME. Please check the logs for details." 6 60
    exit 1
fi