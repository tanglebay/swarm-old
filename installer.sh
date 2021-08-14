#!/bin/bash
export NEWT_COLORS="
root=blue,blue
window=white
border=black
textbox=white
button=black,red
"
if [ ! -f "/var/lib/swarm/swarm" ]; then
    if [ $(id -u) -ne 0 ]; then
        whiptail --title "SWARM" --msgbox "Please run SWARM installer with sudo or as root" 8 65
        exit 0
    else
        if (whiptail --title "SWARM" --yesno "Do you want to install SWARM now?" 10 65); then
            if [ ! -x "$(command -v git)" ]; then
                sudo apt -qq update > /dev/null 2>&1
                sudo apt -qq install git -y > /dev/null 2>&1
            fi
            sudo git clone https://github.com/TangleBay/swarm.git /var/lib/swarm
            if [ -f "/var/lib/swarm/swarm" ]; then
                source /var/lib/swarm/modules/variables
                sudo chmod +x $swarmDir/swarm $plugins/watchdog
                ( crontab -l | grep -v -F "$watchdogCronCmd" ; echo "$watchdogCronJob" ) | crontab - > /dev/null 2>&1
                source $modules/alias
                if [ "$restart" = "false" ]; then
                    source $swarmDir/swarm
                fi
            else
                whiptail --title "SWARM" --msgbox "SWARM could not be successfully cloned from GitHub" 8 65
            fi
        fi
    fi
else
    whiptail --title "SWARM" --msgbox "SWARM is already installed on your system!" 8 65
fi
exit 0