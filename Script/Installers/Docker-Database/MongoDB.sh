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
# 1. Make the docs for github pages
# 2.
# 3.
# 4. 
#
#-----------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------#
# SECTION 1: Logging System Setup
#-----------------------------------------------------------------------------------#

SCRIPT_FILENAME=$(basename "$0")
LOG_DIR="$HOME/UDMS/logs"
LOG_FILE="$LOG_DIR/${SCRIPT_FILENAME}_LOG_FILE_1.log"  # Log file location

# Function to increment log file name
increment_log_file_name() {
  local log_file_base_name="${SCRIPT_FILENAME}_LOG_FILE_"
  local log_file_extension=".log"
  local log_file_counter=1

  while [[ -f "$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}" ]]; do
    ((log_file_counter++))
  done

  LOG_FILE="$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}"
  dialog --clear --backtitle "UDMS - Log file will be saved as" --title "$SCRIPT_FILENAME" --msgbox "$LOG_FILE" 5 60
}

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Increment log file name for this run
increment_log_file_name

# Redirect all output to the log file
exec > >(tee -a "$LOG_FILE") 2>&1

#-----------------------------------------------------------------------------------#
# SECTION 2: Source System
#-----------------------------------------------------------------------------------#

## Pick one or both below. Uncomment the one or both you want.

source ~/UDMS/Core/Core.sh
# source ~/UDMS/Core/ACS-Core.sh

#-----------------------------------------------------------------------------------#
# SECTION 3: Configuration
#-----------------------------------------------------------------------------------#

cd

#-----------------------------------------------------------------------------------#
# SECTION 4: MongoDB Docker Configuration
#-----------------------------------------------------------------------------------#

echo -e "${Green}Starting MongoDB Docker configuration script.${NC}"

echo -e "${Yellow}Do you want to learn more about how to set it up? (Y/N)${NC}"
read -p "Enter your choice: " decision

if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
    echo -e "${Yellow}Set up instructions: $MONGODB_HELPLINK${NC}"
elif [ "$decision" == "N" ] || [ "$decision" == "n" ]; then
    echo -e "${Blue}Skipping setup instructions.${NC}"
fi

# Prompt user for input with defaults
echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the Docker image for MongoDB (e.g., mongo:4.4): " IMAGE
IMAGE=${IMAGE:-"mongo:4.4"}

echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the name for the MongoDB container: " CONTAINER_NAME
CONTAINER_NAME=${CONTAINER_NAME:-"MongoDB"}

echo -e "${Green}This step can be skipped if you don't want any changes to the default settings${NC}"
read -p "Enter the port to expose MongoDB on (e.g., 27017): " PORT
PORT=${PORT:-27017}

# Check if the port is already in use by docker
if [[ $(sudo docker ps -a -q -f "publish=$PORT" | wc -l) -gt 0 ]]; then
    echo -e "${Red}The port $PORT is already in use by another Docker container.${NC}"
    read -p "Enter a different port: " PORT
fi

echo -e "${Yellow}This step can't be skipped${NC}"
read -p "Enter the database user: " DB_USER

# Ensure the user inputs a username
while [ -z "$DB_USER" ]; do
    echo -e "${Red}A database username is required.${NC}"
    read -p "Enter the database user: " DB_USER
done

echo -e "${Yellow}This step can't be skipped${NC}"
read -s -p "Enter the database password: " DB_PASS

# Ensure the user inputs a password
while [ -z "$DB_PASS" ]; do
    echo -e "${Red}A database password is required.${NC}"
    read -s -p "Enter the database password: " DB_PASS
done

echo -e "${Green}This step can be skipped if you don't want any changes to the default settings (mydb)${NC}"
read -p "Enter the default database name: " DB_NAME
DB_NAME=${DB_NAME:-"mongodb"}

# Define the subfolder for the Docker compose files
COMPOSE_SUBFOLDER="$DOCKER_ROOT_FOLDER/$CONTAINER_NAME"
COMPOSE_FILE="$COMPOSE_SUBFOLDER/docker-compose-$CONTAINER_NAME.yml"

# Create the subfolder if it does not exist
mkdir -p "$COMPOSE_SUBFOLDER"

# Create a Docker compose file with the user input
cat > "$COMPOSE_FILE" <<EOF
services:
  $CONTAINER_NAME:
    image: $IMAGE
    container_name: $CONTAINER_NAME
    ports:
      - "$PORT:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=$DB_USER
      - MONGO_INITDB_ROOT_PASSWORD=$DB_PASS
    volumes:
      - ./mongodb-data:/data/db
    restart: always

# Define named volumes
volumes:
  mongodb-data:
    driver: local
EOF

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

#-----------------------------------------------------------------------------------#
# SECTION 5: Final Execution
#-----------------------------------------------------------------------------------#

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
