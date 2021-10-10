# Dependencies
# - curl
# - wget
# - awk
# - grep
# - wc

# Google chrome
if [ $(google-chrome --version 2>/dev/null | grep Google\ Chrome | wc -l) -eq 0 ]; then
    echo "Google Chrome is not installed"
    echo "Installing Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    chromeVersion=$(google-chrome --version | grep Google\ Chrome | awk '{print $3}')
    echo "Google Chrome version $chromeVersion installed"
else
    chromeVersion=$(google-chrome --version | grep Google\ Chrome | awk '{print $3}')
    echo "Google Chrome version $chromeVersion already installed"
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
    echo "Opera version $operaVersion installed"
else
    operaVersion=$(opera --version)
    echo "Opera version $operaVersion already installed"
fi
