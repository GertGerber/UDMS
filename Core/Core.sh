#-----------------------------------------------------------------------------------#
## TO-DO-LIST
# 1. 
# 2.
# 3.
# 4. 
#-----------------------------------------------------------------------------------#

##########################################################################
#####  Set variables for UDMS  # Core.sh # Made for @GertGerber #####
########################## Made for @rune004 #############################
##########################################################################
##### Styles ######
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
BrownOrange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m'
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'
White='\e[1;37m'
NC='\e[0m'  # Reset to default
############################################################################

if [ -f ~/UDMS/.latest_release.txt ]; then
    locally_stored_release=$(cat ~/UDMS/.latest_release.txt)
fi

PROJECT_NAME="UDMS $locally_stored_release (GertGerber Quick Deploy) - Running On $(hostname) IP ($(hostname -I | cut -d' ' -f1))"


# UDMS-Install
DOWNLOAD_UDMS=~/UDMS/Script/UDMS-Install/Download.sh
DOWNLOAD_UDMS_DEV=~/UDMS/Script/UDMS-Install/Pre-Release-Download.sh

## Folders

ROOT_FOLDER=~/UDMS
ROOT_FOLDER_CRONJOB=/root/UDMS
DOCKER_ROOT_FOLDER=~/UDMS-Dockers
SCRIPT_FOLDER=Script
INSTALLER_FOLDER=Installers
MENU_FOLDER=Menu
CRONJOB_FOLDER=Cronjob
LLAMA_GPT_FOLDER=llama-gpt
DOCKER_CNC_FOLDER=Docker-CnC
BACKGROUND=Background
QUICK_TOOLS_DIR=Quick-Tools
YOUTUBE_SCRIPTS_FOLDER=Youtube-Scripts
PRE_MADE_VM_CONFIGS_DIR=Pre-Made-VM-Configs
RRH_SOFTWARE_FOLDER=RRH-Software
ACS_FOLDER=ACS
ACS_SCRIPT_FOLDER=ACSF-Scripts
ACS_DOCKERS=Dockers
ACS_MENUS_FOLDER=ACS-Menus
CRONJOB_MENUS_FOLDER=Cronjob-Menus
DOCKER_MENUS_FOLDER=Docker-Menus
PRE_CONFIGS_MENUS_FOLDER=Pre-Configs-Menus
QUICK_INSTALLERS_MENUS_FOLDER=Quick-Installer-Menus
QUICK_TOOLS_MENUS_FOLDER=Quick-Tools-Menus
BACKGROUND_ACS_AUTOMATED_TASKS=ACS-Automated-Tasks
BACKGROUND_ACS_UPDATE=Automated-Updates
DOCKER_DATABASE_FOLDER=Docker-Database
DOCKER_MONITORING_FOLDER=Docker-Monitoring
DOCKER_SELF_HOSTING_FOLDER_LAN=Docker-Self-Hosting-LAN
DOCKER_SELF_HOSTING_FOLDER_DOMAIN=Docker-Self-Hosting-Domain
RRH_SOFTWARE_MENU_FOLDER=RRH-Software-Menus
HOST_INFO_SYSTEM_FOLDER=Host-Info-System
DEVOPS_FOLDER=DevOps


## Installers Scripts

CLOUDFLARE_TUNNEL="Cloudflare-Tunnel.sh"
MEDIACMS="MediaCMS.sh"
UPTIME_KUMA="Uptime-Kuma.sh"
VAULTWARDEN="Vaultwarden.sh"
NTFY="NTFY.sh"
N8N="N8N.sh"
POSTGRES="Postgres.sh"
MYSQL="MySQL.sh"
CHECKMK="CheckMK.sh"
LLAMA_GPT="Llama-GPT.sh"
PORTAINER="Portainer.sh"
DELUGE="Deluge.sh"
GHOST="Ghost.sh"
LINKWARDEN="Linkwarden.sh"
MEMOS="Memos.sh"
IT_TOOLS="It-tools.sh"
SONARR="Sonarr.sh"
RADARR="Radarr.sh"
OMBI="Ombi.sh"
JACKETT="Jackett.sh"
MONGODB="MongoDB.sh"
DOCKER_REGISTRY="Docker-Registry.sh"
GRAFANA="Grafana.sh"
JENKINS="Jenkins.sh"
GITEA="Gitea.sh"

## Menu Scripts

DOCKER="Docker.sh"
MAIN_MENU="Main.sh"
QUICK_INSTALLERS_DIR="Quick-Installers"
QUICK_INSTALLERS="Quick-Installers.sh"
RRH_SOFTWARE="RRH-Software.sh"
CRONJOB="Cronjob.sh"
DOCKER_CNC="Docker-CnC.sh"
QUICK_TOOLS="Quick-Tools.sh"
YOUTUBE_SCRIPTS="Youtube-Script.sh"
PRE_MADE_VM_CONFIGS="Pre-Made-VM-Configs.sh"
ACS_MENU="ACS.sh"
ACS_UPDATE_MENU="ACS-Update-Menu.sh"
ACS_AUTOMATED_UPDATE_MENU="ACS-Automated-Update.sh"
DOCKER_MENU_DATABASE="Database-Menu.sh"
DOCKER_MENU_MONITORING="Monitoring-Menu.sh"
DOCKER_MENU_LAN_BASED="Self-Hosting-LAN-Based.sh"
DOCKER_MENU_DOMAIN_BASED="Self-Hosting-Domain-Based.sh"
UPDATE_UDMS_MENU="Update-UDMS-Menu.sh"
UPDATE_UDMS="Update-UDMS.sh"


## Quick Installers Scripts

STARSHIP="Starship-Installer.sh"
TAILSCALE="Tailscale-Installer.sh"
FILEZILLA="Filezilla-Installer.sh"
FAIL2BAN="Fail2ban-Installer.sh"
ANSIBLE="Ansible-Installer.sh"
PYDIO="Pydio-Installer.sh"

## Cronjob Scripts

REBOOT_EVERY_NIGHT="Reboot-every-night.sh"
REBOOT_EVERY_SUNDAY="Reboot-every-sunday.sh"
UPDATE_DAILY_MIDNIGHT="Update-daily-midnight.sh"
CRONJOB_MANAGER="Cronjob-Manager.sh"
ADD_CRONMOINTER="Add-Cronmointer.sh"
ADD_WEBP_CONVERTER="Add-Webp-Converter.sh"
ADD_SHORT_CLEANUP="Add-Short-Cleanup.sh"

## Docker CnC Scripts

DOCKER_CLEANUP="Docker-Cleanup.sh"
DOCKER_STOP="Docker-Stop.sh"
DOCKER_START="Docker-Start.sh"
DOCKER_UPDATE="Docker-Update.sh"
DOCKER_RESET="Docker-Reset.sh"
DOCKER_REMOVE="Docker-Remove.sh"
DOCKER_EXPORT="Docker-Export.sh"
DOCKER_IMPORT="Docker-Import.sh"

## Background Jobs

SHORT_CLEANUP="Short-Cleanup.sh"
WEBP_TO_JPEG="Webp-to-JPEG.sh"
ADD_AUTOMATED_DOCKER_UPDATE="Add-Automated-Docker-Update.sh"
ADD_AUTOMATED_FRONTEND_UPDATE="Add-Automated-Frontend-Update.sh"
ADD_AUTOMATED_MOVIE_NODE="Add-Automated-Movie-Node.sh"
ADD_AUTOMATED_SHOW_NODE="Add-Automated-Show-Node.sh"
ADD_AUTOMATED_PLEX_UPDATE="Add-Automated-Plex-Update.sh"

## RRH-Software

ACS_SETUP="setup.sh"
ALIAS_PRE_CONFIG="Alias-Pre-Config.sh"

## Quick Tools Scripts

MANUALLY_INSTALL_SOFTWARE_UPDATE="Manually-Install-Software-Update.sh"
DISK_CLEANUP="ACS-Cleanup.sh"
MOTD_UDMS="UDMS-MOTD.sh"
SSH_KEY_SETUP="SSH-Key-Setup.sh"
SSH_KEY_PUSH="SSH-Key-Push.sh"

## Quick Scripts Scripts

YOUTUBE_DOWNLOAD="Youtube-Download.sh"
YOUTUBE_CHANNEL_DOWNLOAD="Youtube-Channel-Download.sh"
YOUTUBE_CHANNEL_AUTO="Youtube-Channel-Rescan.sh"
YOUTUBE_AUDIO_PLAYLIST="Youtube-Audio-Playlist.sh"
YOUTUBE_STOP_DOWNLOAD="Youtube-Stop-Download.sh"
YOUTUBE_CRONJOB_DOWNLOAD="Youtube-Cronjob-Download.sh"
WEBP_TO_JPEG_MANUEL="Webp-to-JPEG-Manual.sh"

## Pre-Made-VM-Configs

PRE_MADE_VM="RP-Helpdesk-Standard-Config.sh"

# Host Info System
HOST_INFO_COLLECTER="Collect-information.sh"

# DevOps
DOCKER_BUILD="Docker-Builder.sh"
WEBSITE_BUILDER="Website-Builder.sh"
WEBSITE_TEMPLATE_BUILDER="Template-Builder.sh"

## Docker Installer Help Links

GHOST_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Ghost.html"
CLOUDFLARE_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Cloudflare.html"
CHECKMK_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Checkmk.html"
DELUGE_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Deluge.html"
LINKWARDEN_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Linkwarden.html"
IT_TOOLS_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-It-tools.html"
JACKETT_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Jackett.html"
LLAMA_GPT_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Llama-GPT.html"
MEMOS_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Memos.html"
MYSQL_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-MySQL.html"
N8N_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-N8N.html"
NTFY_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-NTFY.html"
OMBI_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Ombi.html"
PORTAINER_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Portainer.html"
POSTGRES_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Postgres.html"
RADARR_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Radarr.html"
SONARR_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Sonarr.html"
UPTIME_KUMA_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Uptime-Kuma.html"
VAULTWARDEN_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Vaultwarden.html"
MONGODB_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-MongoDB.html"
GRAFANA_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Grafana.html"
GITEA_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Gitea.html"
DOCKER_REGISTRY_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Docker-Registry.html"
JENKINS_HELPLINK="https://GertGerber.github.io/UDMS/MkDocs/UDMS/Setup-Jenkins.html"