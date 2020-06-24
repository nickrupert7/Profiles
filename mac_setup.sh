function milestone {
	echo ""
	echo "##############################"
	echo $1
	echo "##############################"
	echo ""
}

milestone "1. INSTALL HOMEBREW"
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

milestone "2. INSTALL PHP"
#brew install php

milestone "3. INSTALL GIT"
#brew install git

milestone "4. INSTALL BASH-COMPLETION"
#brew install bash-completion

milestone "5. INSTALL WGET"
#brew install wget

milestone "6. GET BASH PROFILE"
#wget #TODO/.bash_profile -P ~

milestone "7. GET NANO PROFILE"
#wget #TODO/.nanorc -P ~

milestone "8. CONFIGURE GIT"
#git config --global user.name "Nick Rupert"
#git config --global user.email "nickrupert7@gmail.com"
#git config --global core.editor nano

milestone "9. SETUP SSH"
#mkdir ~/.ssh
#ssh-keygen -f ~/.ssh/github.id_rsa -N ""
#ssh-keygen -f ~/.ssh/bitbucket.id_rsa -N ""
#ssh-keygen -f ~/.ssh/home.nickrupert.id_rsa -N ""
#wget #TODO/config -P ~/.ssh

milestone "10. INSTALL GOOGLE CHROME"
#wget https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg -O ~/Downloads/GoogleChrome.dmg
#hdiutil attach ~/Downloads/GoogleChrome.dmg
#cp -r /Volumes/Google\ Chrome/*.app /Applications/
#diskutil unmount /Volumes/Google\ Chrome

milestone "11. INSTALL DOCKER DESKTOP"
#wget https://download.docker.com/mac/stable/Docker.dmg -O ~/Downloads/Docker.dmg
#hdiutil attach ~/Downloads/Docker.dmg
#cp -r /Volumes/Docker/*.app /Applications/
#diskutil unmount /Volumes/Docker

milestone "12. INSTALL ATOM"
#wget https://atom.io/download/mac -O ~/Downloads/Atom.zip
#unzip ~/Downloads/Atom.zip -d /Applications/

milestone "13. INSTALL PHPSTORM"
#wget "https://download.jetbrains.com/product?code=PS&latest&distribution=mac" -O ~/Downloads/PhpStorm.dmg
#hdiutil attach ~/Downloads/PhpStorm.dmg
#cp -r /Volumes/PhpStorm/*.app /Applications/
#diskutil unmount /Volumes/PhpStorm

milestone "14. INSTALL ANDROID MESSAGES"
#URL=$(curl -s https://api.github.com/repos/chrisknepper/android-messages-desktop/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep .dmg | head -n 1)
#wget $URL -O ~/Downloads/AndroidMessages.dmg
#hdiutil attach ~/Downloads/AndroidMessages.dmg
#cp -r /Volumes/Android\ Messages*/*.app /Applications/
#diskutil unmount /Volumes/Android\ Messages*

milestone "15. CREATE DEVELOPER DIRECTORY"
#mkdir ~/Developer
#TODO Add To Terminal Quick Access Panel

#milestone "16. INSTALL LIGHTHOUSE"
#TODO
