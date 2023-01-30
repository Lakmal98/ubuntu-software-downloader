# Dependencies
# - curl
# - wget
# - awk
# - grep
# - wc

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counter variables
totalCount=0
successCount=0
failCount=0
totalDependencies=0
dependencyCount=0

echo -e "${YELLOW}Updating repositories...${NC}"
sudo apt-get update && clear
echo -e "${PURPLE}Start downloading dependencies...${NC}"

# wc
totalDependencies=$((totalDependencies + 1))
wcExist=$(wc --version 2>/dev/null | head -1)
if [ -z "$wcExist" ]; then
    echo -e "${RED}wc not installed${NC}"
    echo "Installing wc..."
    sudo apt-get -y install wc
    echo -e "${BLUE}$(wc --version | head -1) installed${NC}"
    dependencyCount=$((dependencyCount + 1))
else
    echo -e "${CYAN}$(wc --version | head -1) already installed${NC}"
    dependencyCount=$((dependencyCount + 1))
fi

# grep
totalDependencies=$((totalDependencies + 1))
if [ $(grep --version 2>/dev/null | head -1 | wc -l) -eq 0 ]; then
    echo -e "${RED}grep is not installed.${NC}"
    echo "Installing grep..."
    sudo apt-get -y install grep
    echo -e "${BLUE}$(grep --version 2>/dev/null | head -1) installed.${NC}"
    dependencyCount=$((dependencyCount + 1))
else
    echo -e "${CYAN}$(grep --version 2>/dev/null | head -1) is already installed.${NC}"
    dependencyCount=$((dependencyCount + 1))
fi

# awk
totalDependencies=$((totalDependencies + 1))

awkVersion=$(awk -Wversion 2>/dev/null | head -1 | grep -oP '(?<= )(.*)(?= )')
awlExist=$(awk -Wversion 2>/dev/null | head -1 | grep -oP '(?<= )(.*)(?= )' | wc -l)

if [ $awlExist -eq 0 ]; then
    echo -e "${RED}awk is not installed${NC}"
    echo "Installing awk..."
    sudo apt-get install -y awk
    echo -e "${BLUE}awk version $(awk -Wversion 2>/dev/null | head -1 | grep -oP '(?<= )(.*)(?= )') installed${NC}"
    dependencyCount=$((dependencyCount + 1))
else
    echo -e "${CYAN}awk version $awkVersion already installed${NC}"
    dependencyCount=$((dependencyCount + 1))
fi

# wget
totalDependencies=$((totalDependencies + 1))

wgetVersion=$(wget --version | head -1 | awk '{print $3}' 2>/dev/null)
wgetExist=$(wget --version | head -1 | awk '{print $3}' 2>/dev/null | wc -l)
if [ $wgetExist -eq 0 ]; then
    echo "wget not installed"
    echo "Installing wget"
    sudo apt-get -y install wget
    echo -e "${BLUE}wget version $(wget --version | head -1 | awk '{print $3}') installed${NC}"
    dependencyCount=$((dependencyCount + 1))
else
    echo -e "${CYAN}wget version $wgetVersion already installed${NC}"
    dependencyCount=$((dependencyCount + 1))
fi

# curl
totalDependencies=$((totalDependencies + 1))

curlVersion=$(curl --version | head -1 | awk '{print $2}' 2>/dev/null)
curlExist=$(curl --version | head -1 | awk '{print $2}' 2>/dev/null | wc -l)
if [ $curlExist -eq 0 ]; then
    echo "curl not installed"
    echo "Installing curl"
    sudo apt-get -y install curl
    echo -e "${BLUE}curl version $(curl --version | head -1 | awk '{print $2}') installed${NC}"
    dependencyCount=$((dependencyCount + 1))
else
    echo -e "${CYAN}curl version $curlVersion already installed${NC}"
    dependencyCount=$((dependencyCount + 1))
fi

echo -e "${PURPLE}Dependencies installed $dependencyCount/$totalDependencies${NC}"
if [ $dependencyCount -eq $totalDependencies ]; then
    clear
    echo -e "${GREEN}All dependencies installed successfully${NC}"
    echo -e "${PURPLE}Ready to install software...${NC}"
    sleep 5 && clear
else
    echo -e "${RED}Dependencies not installed successfully${NC}"
    echo -e "${RED}Please install dependencies manually${NC}"
    echo -e "${PURPLE}Exiting...${NC}"
    exit 1
fi

echo -e "${YELLOW}Start downloading software...\n${NC}"

# Switch to downloader directory
cd ~/Downloads
mkdir -p downloader
cd downloader


# Google chrome
if [ $(google-chrome --version 2>/dev/null | grep Google\ Chrome | wc -l) -eq 0 ]; then
    echo "Google Chrome is not installed"
    echo "Installing Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    chromeVersion=$(google-chrome --version | grep Google\ Chrome | awk '{print $3}')
    echo -e "${BLUE}Google Chrome version $chromeVersion installed${NC}"
else
    chromeVersion=$(google-chrome --version | grep Google\ Chrome | awk '{print $3}')
    echo -e "${GREEN}Google Chrome version $chromeVersion already installed${NC}"
fi

# Opera
if [ $(opera --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Opera is not installed"
    echo "Installing Opera"
    version=$(curl --location --request GET 'https://download1.operacdn.com/pub/opera/desktop/' | tail -3 | grep -oP '(?<=\/">).*(?=\/<\/a>)')
    wget https://download1.operacdn.com/pub/opera/desktop/$version/linux/opera-stable_$version\_amd64.deb
    sudo dpkg -i opera-stable_$version\_amd64.deb
    rm opera-stable_$version\_amd64.deb
    operaVersion=$(opera --version)
    echo -e "${BLUE}Opera version $operaVersion installed${NC}"
else
    operaVersion=$(opera --version)
    echo -e "${GREEN}Opera version $operaVersion already installed${NC}"
fi

# VSCode
if [ $(code --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "VSCode is not installed"
    echo "Installing VSCode ..."
    # set wget downloding file name
    wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo dpkg -i vscode.deb
    rm vscode.deb
    codeVersion=$(code --version | head -1)
    echo -e "${BLUE}VSCode version $codeVersion installed${NC}"
else
    codeVersion=$(code --version | head -1)
    echo -e "${GREEN}VSCode version $codeVersion already installed${NC}"
fi

# VLC Player
if [ $(vlc --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "VLC Player is not installed"
    echo "Installing VLC Player ..."
    # get latest version
    latestVersion=$(curl GET https://download.videolan.org/pub/videolan/vlc/last/ | grep -oP '(?<=\>vlc-).*(?=.tar.xz)' | head -1)
    # download vlc for ubuntu deb
    wget https://download.videolan.org/pub/videolan/vlc/last/vlc-$latestVersion.tar.xz
    # unzip vlc to /opt/vlc
    sudo tar -xvf vlc-$latestVersion.tar.xz -C /opt
    # remove vlc.tar.xz
    rm vlc-$latestVersion.tar.xz

    # create icon for vlc
    sudo touch /usr/share/applications/vlc.desktop
    sudo chmod +x /usr/share/applications/vlc.desktop
    sudo echo "[Desktop Entry]" >>/usr/share/applications/vlc.desktop
    sudo echo "Name=VLC media player" >>/usr/share/applications/vlc.desktop
    sudo echo "GenericName=Multimedia Player" >>/usr/share/applications/vlc.desktop
    sudo echo "Exec=/opt/vlc/vlc" >>/usr/share/applications/vlc.desktop
    sudo echo "Icon=/opt/vlc/share/vlc/icons/128x128/vlc-logo.png" >>/usr/share/applications/vlc.desktop
    sudo echo "Terminal=false" >>/usr/share/applications/vlc.desktop
    sudo echo "Type=Application" >>/usr/share/applications/vlc.desktop
    sudo echo "Categories=Multimedia;" >>/usr/share/applications/vlc.desktop
    sudo echo "StartupNotify=true" >>/usr/share/applications/vlc.desktop
    sudo echo "StartupWMClass=vlc" >>/usr/share/applications/vlc.desktop

    vlcVersion=$(vlc --version 2>/dev/null | head -1 | awk '{print $3}')
    echo -e "${BLUE}VLC Player version $vlcVersion installed${NC}"
else
    vlcVersion=$(vlc --version 2>/dev/null | head -1 | awk '{print $3}')
    echo -e "${GREEN}VLC Player version $vlcVersion already installed${NC}"
fi

# Zoom
if [ $(dpkg -s zoom | grep -i version | awk '{print $2}' 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Zoom is not installed"
    echo "Installing Zoom ..."
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo dpkg -i zoom_amd64.deb
    rm zoom_amd64.deb
    zoomVersion=$(dpkg -s zoom | grep -i version | awk '{print $2}' | awk '{print $3}')
    echo -e "${BLUE}Zoom version $zoomVersion installed${NC}"
else
    zoomVersion=$(dpkg -s zoom | grep -i version | awk '{print $2}' | awk '{print $3}')
    echo -e "${GREEN}Zoom version $zoomVersion already installed${NC}"
fi

# Postman
# Check Postman exist withing the system

if [ -f "/opt/postman/Postman" ]; then
    echo "Postman is not installed"
    echo "Installing Postman ..."
    wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
    sudo tar -xzf postman.tar.gz -C /opt
    rm postman.tar.gz

    # create icon for postman
    sudo touch /usr/share/applications/postman.desktop
    sudo chmod +x /usr/share/applications/postman.desktop
    sudo echo "[Desktop Entry]" >>/usr/share/applications/postman.desktop
    sudo echo "Name=Postman" >>/usr/share/applications/postman.desktop
    sudo echo "GenericName=API Client" >>/usr/share/applications/postman.desktop
    sudo echo "Exec=/opt/Postman/Postman" >>/usr/share/applications/postman.desktop
    sudo echo "Icon=/opt/Postman/app/resources/app/assets/icon.png" >>/usr/share/applications/postman.desktop
    sudo echo "Terminal=false" >>/usr/share/applications/postman.desktop
    sudo echo "Type=Application" >>/usr/share/applications/postman.desktop
    sudo echo "Categories=Development;" >>/usr/share/applications/postman.desktop
    sudo echo "StartupNotify=true" >>/usr/share/applications/postman.desktop
    sudo echo "StartupWMClass=Postman" >>/usr/share/applications/postman.desktop

    echo -e "${BLUE}Postman installed${NC}"
else
    echo -e "${GREEN}Postman already installed${NC}"
fi

# snap store and snapd
if [ $(snap list 2>/dev/null | grep -i snapd | wc -l) -eq 0 ]; then
    echo "Snapd is not installed"
    echo "Installing Snapd ..."
    sudo apt install snapd
    snapVersion=$(snap --version | head -1 | awk '{print $2}')
    echo -e "${BLUE}Snapd version $snapVersion installed${NC}"
else
    snapVersion=$(snap --version | head -1 | awk '{print $2}')
    echo -e "${GREEN}Snapd version $snapVersion already installed${NC}"
fi

# Slack
if [ $(slack --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Slack is not installed"
    echo "Installing Slack ..."
    echo "Downloading Slack with snap ..."
    sudo snap install slack --classic
    slackVersion=$(slack --version)
    echo -e "${BLUE}Slack version $slackVersion installed${NC}"
else
    slackVersion=$(slack --version)
    echo -e "${GREEN}Slack version $slackVersion already installed${NC}"
fi

# nvm
export NVM_DIR=$HOME/.nvm
source $NVM_DIR/nvm.sh

if [ $(nvm --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "NVM is not installed"
    echo "Installing NVM ..."
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    # load environment variables
    source ~/.profile
    nvmVersion=$(nvm --version)
    echo -e "${BLUE}NVM version $nvmVersion installed${NC}"
else
    nvmVersion=$(nvm --version)
    echo -e "${GREEN}NVM version $nvmVersion already installed${NC}"
fi

# Node JS
nvm install stable
nvm install 14
nvm install 16
nvm use stable

# Git
if [ $(git --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Git is not installed"
    echo "Installing Git ..."
    sudo apt-get install git
    gitVersion=$(git --version | head -1 | awk '{print $3}')
    echo -e "${BLUE}Git version $gitVersion installed${NC}"
else
    gitVersion=$(git --version | head -1 | awk '{print $3}')
    echo -e "${GREEN}Git version $gitVersion already installed${NC}"
fi

# Java Runtime environment
if [ $(java --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Java Runtime Environment is not installed"
    echo "Installing Java Runtime Environment ..."
    sudo apt-get install default-jre
    javaVersion=$(java --version | head -1 | awk '{print $2}')
    echo -e "${BLUE}Java Runtime Environment version $javaVersion installed${NC}"
else
    javaVersion=$(java --version | head -1 | awk '{print $2}')
    echo -e "${GREEN}Java Runtime Environment version $javaVersion already installed${NC}"
fi

# Flameshot
if [ $(flameshot --version 2>/dev/null | wc -l) -eq 0 ]; then
    echo "Flameshot is not installed"
    echo "Installing Flameshot ..."
    sudo apt-get install flameshot -y
    flameshotVersion=$(flameshot --version)
    echo -e "${BLUE}Flameshot version $flameshotVersion installed${NC}"
else
    flameshotVersion=$(flameshot --version)
    echo -e "${GREEN}Flameshot version $flameshotVersion already installed${NC}"
fi

# Clear Terminal
clear

# Installation Complete
echo -e "${GREEN}Installation Complete${NC}"

# Empty trash
echo -e "${BLUE}Emptying trash${NC}"
sudo rm -rf ~/.local/share/Trash/*

# clear all Downloads
echo "Cleaning all Downloads ..."
rm -rf ~/Downloads/downloader/*

# remove downloader directory
echo "Removing downloader directory ..."
rm -rf ~/Downloads/downloader

# All set up message
echo -e "${GREEN}All set up!${NC}"

# Update and Upgrade
echo -e "${BLUE}Updating and Upgrading${NC}"
sudo apt update && sudo apt upgrade -y

# ask to reboot
echo -e "${BLUE}Reboot is required${NC}"
echo -e "${BLUE}Do you want to reboot now?${NC}"
select yn in "Y" "y" "N" "n"; do
    case $yn in
    [Yy]*)
        echo -e "${BLUE}Rebooting ...${NC}"
        sudo reboot
        break
        ;;
    [Nn]*)
        echo -e "${BLUE}Reboot later ...${NC}"
        break
        ;;
    esac
done

# End of script
