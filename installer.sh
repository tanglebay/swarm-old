#!/bin/bash
clear
export NEWT_COLORS="
root=blue,blue
window=white
border=black
textbox=white
button=black,red
"
if [ "$1" = "-reinstall" ]; then
    if [ -d "/var/lib/swarm" ]; then
        sudo rm -rf /var/lib/swarm > /dev/null 2>&1
    fi
fi

if [ ! -f "/var/lib/swarm/swarm" ]; then
    if [ $(id -u) -ne 0 ]; then
        whiptail --title "SWARM" --msgbox "Please run SWARM installer with sudo or as root!" 8 65
        exit 0
    else
        if (whiptail --title "SWARM" --yesno "Do you want to install SWARM now?" 10 65); then
            whiptail --title "SWARM" --msgbox "SWARM will first make sure that your server is up to date..." 8 65
            sudo apt update
            sudo apt dist-upgrade -y
            sudo apt upgrade -y
            sudo apt autoremove -y
            {
                echo 0
                echo 10
                if [ ! -x "$(command -v git)" ]; then
                    sudo apt -qq install git -y > /dev/null 2>&1
                fi
                echo 30
                sudo git clone https://github.com/TangleBay/swarm.git /var/lib/swarm > /dev/null 2>&1
                echo 50
                if [ -f "/var/lib/swarm/swarm" ]; then
                    source /var/lib/swarm/environment
                    sudo chmod +x $swarmHome/swarm $swarmPlugins/watchdog
                    echo 70
                    ( crontab -l | grep -v -F "$watchdogCronCmd" ; echo "$watchdogCronJob" ) | crontab - > /dev/null 2>&1
                    echo 100
                    clear
                fi
            } | whiptail --gauge "Please wait while SWARM is installed..." 8 65 0
            if [ -f "/var/lib/swarm/swarm" ]; then
                source /var/lib/swarm/environment
                source $swarmModules/swarmAlias
                clear
                if [ "$swarmAliasExists" = "true" ]; then
                    source $swarmHome/swarm
                fi
            else
                whiptail --title "SWARM" --msgbox "SWARM could not be successfully cloned from GitHub!" 8 65
            fi
        fi
    fi
else
    whiptail --title "SWARM" --msgbox "SWARM is already installed on your system!" 8 65
fi
exit 0