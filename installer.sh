#!/bin/bash
TEXT_RESET='\e[0m'
TEXT_RED_B='\e[1;31m'
clear
if [ "$1" = "reinstall" ]; then
    if [ -d "/var/lib/swarm" ]; then
        sudo rm -rf /var/lib/swarm > /dev/null 2>&1
    fi
fi

if [ ! -f "/var/lib/swarm/swarm" ]; then
    if [ $(id -u) -ne 0 ]; then
        echo ""
        echo "     _______          __     _____  __  __ "
        echo "    / ____\ \        / /\   |  __ \|  \/  |"
        echo "   | (___  \ \  /\  / /  \  | |__) | \  / |"
        echo "    \___ \  \ \/  \/ / /\ \ |  _  /| |\/| |"
        echo "    ____) |  \  /\  / ____ \| | \ \| |  | |"
        echo "   |_____/    \/  \/_/    \_\_|  \_\_|  |_|"
        echo ""                                            
        echo ""                                            
        echo "###################################################"
        echo ""
        echo -e $TEXT_RED_B && echo "-> Please run SWARM installer with sudo or as root" && echo -e $TEXT_RESET
        echo ""
        read -n 1 -s -r -p "Press any key to continue"
        exit 0
    else
        echo ""
        echo "     _______          __     _____  __  __ "
        echo "    / ____\ \        / /\   |  __ \|  \/  |"
        echo "   | (___  \ \  /\  / /  \  | |__) | \  / |"
        echo "    \___ \  \ \/  \/ / /\ \ |  _  /| |\/| |"
        echo "    ____) |  \  /\  / ____ \| | \ \| |  | |"
        echo "   |_____/    \/  \/_/    \_\_|  \_\_|  |_|"
        echo ""                                            
        echo ""                                            
        echo "###################################################"
        echo ""
        read -p "Do you want to install SWARM now?(Y/n) " keyboardInput </dev/tty
        keyboardInput=$(echo $keyboardInput | tr '[:upper:]' '[:lower:]')
        if [ "$keyboardInput" = "y" ] || [ "$keyboardInput" = "yes" ] || [ -z "$keyboardInput" ]; then
            echo ""
            echo -e $TEXT_RED_B && echo "-> Updating OS..." && echo -e $TEXT_RESET
            echo ""
            sudo apt update
            sudo apt dist-upgrade -y
            sudo apt upgrade -y
            sudo apt autoremove -y

            if [ ! -x "$(command -v git)" ]; then
                echo -e $TEXT_RED_B && echo "-> Installing GIT..." && echo -e $TEXT_RESET
                sudo apt install git -y
            fi
            echo -e $TEXT_RED_B && echo "-> Cloning SWARM..." && echo -e $TEXT_RESET
            sudo git clone https://github.com/TangleBay/swarm.git /var/lib/swarm
            if [ "$1" = "develop" ]; then
                ( cd /var/lib/swarm ; sudo git checkout $1 )
            fi

            if [ -f "/var/lib/swarm/swarm" ]; then
                echo -e $TEXT_RED_B && echo "-> Loading env..." && echo -e $TEXT_RESET
                source /var/lib/swarm/environment
                sudo chmod +x $swarmHome/swarm $swarmPlugins/watchdog
                echo -e $TEXT_RED_B && echo "-> Installing watchdog..." && echo -e $TEXT_RESET
                ( crontab -l | grep -v -F "$watchdogCronCmd" ; echo "$watchdogCronJob" ) | crontab -
            fi

            if [ -f "/var/lib/swarm/swarm" ]; then
                source /var/lib/swarm/environment
                echo -e $TEXT_RED_B && echo "-> Installing aliases..." && echo -e $TEXT_RESET
                source $swarmModules/swarmAlias
                if [ "$swarmAliasExists" = "true" ]; then
                    echo -e $TEXT_RED_B && echo "-> Starting SWARM..." && echo -e $TEXT_RESET
                    source $swarmHome/swarm
                fi
            else
                echo ""
                echo -e $TEXT_RED_B && echo "-> SWARM could not be successfully cloned from GitHub." && echo -e $TEXT_RESET
                echo ""
            fi
            echo ""
            echo ""
            read -n 1 -s -r -p "Press any key to exit."
            clear
        else
            echo -e $TEXT_RED_B && echo "-> SWARM installation canceled." && echo -e $TEXT_RESET
            echo ""
            read -n 1 -s -r -p "Press any key to exit."
            clear
        fi
    fi
else
    echo ""
    echo -e $TEXT_RED_B && echo "SWARM is already installed on your system." && echo -e $TEXT_RESET
    echo ""
fi
exit 0