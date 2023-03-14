#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_RED_B='\e[1;31m'

clear
echo ""
echo " _______      _  _  _      _______       ______      _______"
echo " |______      |  |  |      |_____|      |_____/      |  |  |"
echo " ______|      |__|__|      |     |      |    \_      |  |  |"
echo ""
echo "============================================================="
echo ""
if [ $(id -u) -ne 0 ]; then

    echo -e $TEXT_RED_B && echo "-> Please run SWARM installer with sudo or as root" && echo -e $TEXT_RESET
    echo ""
    read -rsn1 -p "Press any key to exit."
    exit 0
else
    osArchitecture=$(sudo dpkg --print-architecture)
    if [ "$osArchitecture" = "amd64" ] || [ "$osArchitecture" = "arm64" ]; then
        if [ -d "/var/lib/swarm" ]; then
            swarmAlreadyExist=true
            swarmReinstall="re-"
        fi
        # if [ -z "$keyboardInputUsername" ]; then
        #     read -p "Please enter your username: " keyboardInputUsername </dev/tty
        #     echo ""
        # fi
        # if [ -z "$keyboardInputPassword" ]; then
        #     read -s -p "Please enter your password: " keyboardInputPassword </dev/tty
        #     echo ""
        # fi
        # if [ ! -z "$keyboardInputUsername" ] && [ ! -z "$keyboardInputPassword" ]; then
            latestSwarmVersion=$(curl --max-time 5 -Ls https://cdn.tanglebay.com/swarm/version/stable | head -n 1)
            latestSwarmVersion=$(echo $latestSwarmVersion | tr -d 'v')
            # checkSwarmUpdateAuth=$(curl -s -o /dev/null -w "%{http_code}" https://cdn.tanglebay.com/test.file)
            checkSwarmUpdateAuth=200
            if [ "$checkSwarmUpdateAuth" = "200" ] && [ ! -z "$latestSwarmVersion" ]; then
                clear
                echo ""
                echo " _______      _  _  _      _______       ______      _______"
                echo " |______      |  |  |      |_____|      |_____/      |  |  |"
                echo " ______|      |__|__|      |     |      |    \_      |  |  |"
                echo ""
                echo "============================================================="
                echo ""
                read -p "Do you want to ${swarmReinstall}install SWARM now?(Y/n) " keyboardInput </dev/tty
                keyboardInput=$(echo $keyboardInput | tr '[:upper:]' '[:lower:]')
                if [ "$keyboardInput" = "y" ] || [ "$keyboardInput" = "yes" ] || [ -z "$keyboardInput" ]; then
                    swarmTmp="/tmp/swarm"
                    echo ""
                    echo -e $TEXT_RED_B && echo "-> Updating OS..." && echo -e $TEXT_RESET
                    echo ""
                    sudo apt update
                    sudo apt dist-upgrade -y
                    sudo apt upgrade -y
                    sudo apt autoremove -y
                    echo -e $TEXT_RED_B && echo "-> Installing packages..." && echo -e $TEXT_RESET
                    if ! [ -x "$(command -v whiptail)" ] > /dev/null 2>&1; then
                        sudo apt -qq install whiptail -y > /dev/null 2>&1
                    fi
                    sudo apt  install software-properties-common -y
                    echo -e $TEXT_RED_B && echo "-> Downloading SWARM..." && echo -e $TEXT_RESET
                    if [ ! -d "$swarmTmp" ]; then
                        sudo mkdir -p $swarmTmp/installer > /dev/null 2>&1
                    fi
                    sudo wget -q -O $swarmTmp/installer/swarm-v$latestSwarmVersion.tar.gz https://cdn.tanglebay.com/swarm/v$latestSwarmVersion/swarm-v$latestSwarmVersion.tar.gz
                    echo ""
                    echo -e $TEXT_RED_B && echo "-> Verify checksum of SWARM..." && echo -e $TEXT_RESET
                    echo ""
                    swarmChkSum=$(curl -s https://cdn.tanglebay.com/swarm/v$latestSwarmVersion/checksum.txt)
                    swarmUpdateChkSum=$(shasum -a 512 $swarmTmp/installer/swarm-v$latestSwarmVersion.tar.gz | awk '{ print $1 }')
                    if [ "$swarmChkSum" = "$swarmUpdateChkSum" ]; then
                        ( cd $swarmTmp/installer ; sudo tar -xzf $swarmTmp/installer/swarm-v$latestSwarmVersion.tar.gz ) > /dev/null 2>&1
                        if [ -f "$swarmTmp/installer/swarm/swarm" ]; then
                            if [ "$swarmAlreadyExist" = "true" ]; then
                                sudo cp -rf /var/lib/swarm/configs /tmp/swarm/installer/ > /dev/null 2>&1
                                sudo rm -rf /var/lib/swarm > /dev/null 2>&1
                                sudo cp -rf $swarmTmp/installer/swarm /var/lib > /dev/null 2>&1
                                sudo cp -rf /tmp/swarm/installer/configs/*.cfg /var/lib/swarm/configs/ > /dev/null 2>&1
                                sudo cp -rf $swarmTmp/installer/swarm/configs/swarm.cfg /var/lib/swarm/configs/swarm.cfg > /dev/null 2>&1
                                if [ -f "/var/lib/swarm/configs/hornet.cfg" ]; then
                                    echo -e $TEXT_RED_B && echo "-> Migration of Hornet (IOTA)..." && echo -e $TEXT_RESET
                                    source /var/lib/swarm/swarm/swarmHornetMigration
                                fi
                            else
                                sudo cp -rf $swarmTmp/installer/swarm /var/lib > /dev/null 2>&1
                                sudo rm -rf $swarmTmp/installer > /dev/null 2>&1
                            fi
                            if [ -f "/var/lib/swarm/swarm" ]; then
                                echo -e $TEXT_RED_B && echo "-> Loading env..." && echo -e $TEXT_RESET
                                source /var/lib/swarm/environment
                                sudo chmod +x /var/lib/swarm/swarm /var/lib/swarm/watchdog
                                echo -e $TEXT_RED_B && echo "-> Installing watchdog..." && echo -e $TEXT_RESET
                                ( crontab -l | grep -v -F "$watchdogCronCmd" ; echo "$watchdogCronJob" ) | crontab - > /dev/null 2>&1
                                sudo sed -i 's~^swarmAuthUser=.*~swarmAuthUser="'$keyboardInputUsername'"~g' $swarmConfigs/swarm.cfg 2>/dev/null
                                sudo sed -i 's~^swarmAuthPwd=.*~swarmAuthPwd="'$keyboardInputPassword'"~g' $swarmConfigs/swarm.cfg 2>/dev/null
                            fi

                            if [ -f "/var/lib/swarm/swarm" ]; then
                                source /var/lib/swarm/environment
                                if [ ! -f "/etc/profile.d/00-swarm.sh" ]; then
                                    echo -e $TEXT_RED_B && echo "-> Installing aliases..." && echo -e $TEXT_RESET
                                    sudo cat /var/lib/swarm/templates/swarm/00-swarm.sh > /etc/profile.d/00-swarm.sh
                                    if ! (grep -o "alias swarm='sudo /var/lib/swarm/swarm'" /root/.bashrc > /dev/null 2>&1); then
                                        echo "alias swarm='sudo /var/lib/swarm/swarm'" >> /root/.bashrc
                                    fi
                                    echo ""
                                    echo -e $TEXT_RED_B && echo "-> SWARM successfully installed and alias \"swarm\" has been added to your system!" &&
                                    echo "   To make the change effective you will be logged out once now. You can then log in again and use the command \"swarm\" (without the quotes) to run the script." && echo -e $TEXT_RESET
                                    echo ""
                                    read -p "Do you want to start SWARM now?(Y/n) " keyboardInput </dev/tty
                                    keyboardInput=$(echo $keyboardInput | tr '[:upper:]' '[:lower:]')
                                    if [ "$keyboardInput" = "y" ] || [ "$keyboardInput" = "yes" ] || [ -z "$keyboardInput" ]; then
                                        source /var/lib/swarm/swarm
                                    else
                                        clear
                                        exit 0
                                    fi
                                else
                                    echo ""
                                    echo -e $TEXT_RED_B && echo "-> SWARM successfully ${swarmReinstall}installed." && echo -e $TEXT_RESET
                                    if [ "$swarmAlreadyExist" = "true" ]; then
                                        echo ""
                                        read -rsn1 -p "Press any key to exit."
                                        unset keyboardInputUsername keyboardInputPassword latestSwarmVersion swarmChkSum swarmUpdateChkSum swarmAlreadyExist swarmReinstall
                                        exit 0
                                    else
                                        echo ""
                                        read -p "Do you want to start SWARM now?(Y/n) " keyboardInput </dev/tty
                                        keyboardInput=$(echo $keyboardInput | tr '[:upper:]' '[:lower:]')
                                        if [ "$keyboardInput" = "y" ] || [ "$keyboardInput" = "yes" ] || [ -z "$keyboardInput" ]; then
                                            source /var/lib/swarm/swarm
                                        else
                                            clear
                                            unset keyboardInputUsername keyboardInputPassword latestSwarmVersion swarmChkSum swarmUpdateChkSum swarmAlreadyExist swarmReinstall
                                            exit 0
                                        fi
                                    fi
                                fi
                            else
                                echo ""
                                echo -e $TEXT_RED_B && echo "-> SWARM could not be successfully installed." && echo -e $TEXT_RESET
                                echo ""
                            fi
                            echo ""
                            echo ""
                            read -rsn1 -p "Press any key to exit."
                        fi
                    else
                        if [ -d "/var/lib/swarm" ]; then
                            sudo rm -rf /tmp/swarm/installer > /dev/null 2>&1
                        else
                            sudo rm -rf /tmp/swarm > /dev/null 2>&1
                        fi
                        echo ""
                        echo -e $TEXT_RED_B && echo "-> SWARM installation canceled as the checksum does not match." && echo -e $TEXT_RESET
                        echo ""
                        read -rsn1 -p "Press any key to exit."
                    fi
                else
                    echo -e $TEXT_RED_B && echo "-> SWARM installation canceled." && echo -e $TEXT_RESET
                    echo ""
                    read -rsn1 -p "Press any key to exit."
                fi
            else
                echo -e $TEXT_RED_B && echo "-> SWARM installation canceled because authentication failed." && echo -e $TEXT_RESET
                echo ""
                read -rsn1 -p "Press any key to exit."
            fi
        # else
        #     echo -e $TEXT_RED_B && echo "-> SWARM installation canceled because authentication failed." && echo -e $TEXT_RESET
        #     echo ""
        #     read -rsn1 -p "Press any key to exit."
        # fi
    else
        echo -e $TEXT_RED_B && echo "-> Aborted - SWARM only supports operating systems with \"amd64\" or \"arm64\"." && echo -e $TEXT_RESET
        echo ""
        read -rsn1 -p "Press any key to exit."
        clear
        exit 0
    fi
fi

unset keyboardInputUsername keyboardInputPassword latestSwarmVersion swarmChkSum swarmUpdateChkSum swarmAlreadyExist swarmReinstall
clear
exit 0