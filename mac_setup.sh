function milestone {
	echo ""
	echo "##############################"
	echo "$1"
	echo "##############################"
	echo ""
}

########################################
# INSTALL HOMEBREW
########################################
milestone "INSTALL HOMEBREW"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

########################################
# INSTALL PHP
########################################
# This step may take a while...
milestone "INSTALL PHP"
brew install php

########################################
# UPDATE PHP INI
########################################
milestone "UPDATE PHP INI"
INI_FILE=$(php --ini | grep "Loaded Configuration File" | awk '{print $4}')
# Set php memory_limit to -1 (unlimited)
# This is important for preventing errors during `composer install` in some projects
sed -i '' 's/memory_limit =.*/memory_limit = -1/g' $INI_FILE

########################################
# INSTALL GIT
########################################
milestone "INSTALL GIT"
brew install git

########################################
# INSTALL BASH-COMPLETION FOR GIT
########################################
milestone "INSTALL BASH-COMPLETION"
brew install bash-completion

########################################
# INSTALL WGET
########################################
milestone "INSTALL WGET"
brew install wget

########################################
# INSTALL BASH PROFILE
########################################
milestone "GET BASH PROFILE"
wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/.bash_profile -O ~/.bash_profile

########################################
# INSTALL NANO
########################################
milestone "GET NANO PROFILE"
wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/.nanorc -O ~/.nanorc

########################################
# CONFIGURE GIT
########################################
milestone "CONFIGURE GIT"
git config --global user.name "Nick Rupert"
git config --global user.email "nickrupert7@gmail.com"
git config --global core.editor nano

########################################
# INSTALL GIT SCRIPTS
########################################
milestone "INSTALL GIT SCRIPTS"
wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-tree -O /usr/local/bin/git-tree
chmod +x /usr/local/bin/git-tree
wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-trim -O /usr/local/bin/git-trim
chmod +x /usr/local/bin/git-trim
wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-update -O /usr/local/bin/git-update
chmod +x /usr/local/bin/git-update

########################################
# SETUP SSH
########################################
milestone "SETUP SSH"
mkdir ~/.ssh
ssh-keygen -f ~/.ssh/github.id_rsa -N ""
ssh-keygen -f ~/.ssh/bitbucket.id_rsa -N ""
ssh-keygen -f ~/.ssh/home.nickrupert.id_rsa -N ""
#TODO wget ssh-config -O ~/.ssh/config

########################################
# CREATE DEVELOPER DIRECTORY
########################################
milestone "CREATE DEVELOPER DIRECTORY"
mkdir ~/Developer
# TODO Add To Finder Quick Access Panel

########################################
# INSTALL GOOGLE CHROME
########################################
milestone "INSTALL GOOGLE CHROME"
wget https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg -O ~/Downloads/GoogleChrome.dmg
hdiutil attach ~/Downloads/GoogleChrome.dmg
cp -r /Volumes/Google\ Chrome/*.app /Applications/
diskutil unmount /Volumes/Google\ Chrome

########################################
# INSTALL DOCKER DESKTOP
########################################
milestone "INSTALL DOCKER DESKTOP"
wget https://download.docker.com/mac/stable/Docker.dmg -O ~/Downloads/Docker.dmg
hdiutil attach ~/Downloads/Docker.dmg
cp -r /Volumes/Docker/*.app /Applications/
diskutil unmount /Volumes/Docker

########################################
# INSTALL ATOM
########################################
milestone "INSTALL ATOM"
wget https://atom.io/download/mac -O ~/Downloads/Atom.zip
unzip ~/Downloads/Atom.zip -d /Applications/

########################################
# INSTALL PHPSTORM
########################################
milestone "INSTALL PHPSTORM"
wget "https://download.jetbrains.com/product?code=PS&latest&distribution=mac" -O ~/Downloads/PhpStorm.dmg
hdiutil attach ~/Downloads/PhpStorm.dmg
cp -r /Volumes/PhpStorm/*.app /Applications/
diskutil unmount /Volumes/PhpStorm

########################################
# INSTALL ANDROID MESSAGES
########################################
milestone "INSTALL ANDROID MESSAGES"
URL=$(curl -s https://api.github.com/repos/chrisknepper/android-messages-desktop/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep .dmg | head -n 1)
wget $URL -O ~/Downloads/AndroidMessages.dmg
hdiutil attach ~/Downloads/AndroidMessages.dmg
cp -r /Volumes/Android\ Messages*/*.app /Applications/
diskutil unmount /Volumes/Android\ Messages*

########################################
# INSTALL POSTMAN
########################################
milestone "INSTALL POSTMAN"
wget "https://dl.pstmn.io/download/latest/osx" -O ~/Downloads/Postman.zip
unzip ~/Downloads/Postman.zip -d /Applications/

########################################
# INSTALL CHROME REMOTE DESKTOP
########################################
milestone "INSTALL CHROME REMOTE DESKTOP"
wget "https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg" -O ~/Downloads/ChromeRemoteDesktop.dmg
hdiutil attach ~/Downloads/ChromeRemoteDesktop.dmg
sudo installer -pkg /Volumes/Chrome*/*.pkg -target /
diskutil unmount /Volumes/Chrome*

########################################
# INSTALL SPOTIFY
########################################
milestone "INSTALL SPOTIFY"
wget "https://download.scdn.co/SpotifyInstaller.zip" -O ~/Downloads/Spotify.zip
unzip ~/Downloads/Spotify.zip -d ~/Downloads
open ~/Downloads/*Spotify.app

########################################
# INSTALL SLACK
########################################
milestone "INSTALL SLACK"
# Slack cannot be installed automatically, but must be installed from the App Store
# This will open the App Store, but you must click the button to activate the install
open -a "App Store.app" https://itunes.apple.com/app/slack/id803453959

########################################
# INSTALL LIGHTHOUSE
########################################
# milestone "INSTALL LIGHTHOUSE"
# TODO

########################################
# CONFIGURE SYSTEM PREFERENCES
########################################
milestone "CONFIGURE SYSTEM PREFERENCES"
# Enable Dark Mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to 1'

# Set touch bar to traditional control strip only
defaults write com.apple.touchbar.agent PresentationModeGlobal fullControlStrip

# Set order of touch bar strip items
defaults write com.apple.controlstrip FullCustomized '(NSTouchBarItemIdentifierFlexibleSpace, "com.apple.system.launchpad", "com.apple.system.group.brightness", "com.apple.system.group.keyboard-brightness", "com.apple.system.group.media", "com.apple.system.group.volume")'

# Set bottom left hot corner to "Disable Screensaver"
defaults write com.apple.dock wvous-bl-corner -int 6
defaults write com.apple.dock wvous-bl-modifier -int 0

# Set bottom right corner to "Put Display to Sleep"
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

# Mission Control disable "Automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces 0

# Set menu bar date format
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm:ss a"

# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent YES

# Clear Dock apps
defaults delete com.apple.dock persistent-apps

# Add Google Chrome, Mail, Spotify, PhpStorm, Terminal, Slack, Android Messages, and Stickies to Dock
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Mail.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/PhpStorm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Utilities/Terminal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Android Messages.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Stickies.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Clear Dock persistent others
defaults delete com.apple.dock persistent-others

# Add Downloads Folder to persistent others (Order By: Date Added, Display As: Stack, View As: Fan)
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>2</integer><key>displayas</key><integer>0</integer><key>showas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>file://$HOME/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict><key>tile-type</key><string>directory-tile</string></dict>"

# Set Google Chrome as default browser. This will usually open a confirmation modal, and you must click "Use Google Chrome"
open -a "Google Chrome" --args --make-default-browser

# Restart system services after settings changes
pkill "Touch Bar agent"
killall "ControlStrip"
killall Dock
killall SystemUIServer

milestone $'FINISHED\nWhen you are ready, plese restart your computer for configuration settings to take effect'
