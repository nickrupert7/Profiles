function milestone {
	echo ""
	echo "##############################"
	echo "$1"
	echo "##############################"
	echo ""
}

function addHost {
	if ! grep -q "$2" "/etc/hosts"; then
		echo "$1 $2" >> /etc/hosts
	fi
}

########################################
# APT UPDATE
########################################
function aptUpdate {
	milestone "APT UPDATE"
	sudo apt update
	sudo apt upgrade -y
	sudo apt install software-properties-common -y
	sudo apt update
}


########################################
# INSTALL FLATPAK
########################################
function installFlatpak {
	milestone "INSTALL FLATPAK"
	sudo add-apt-repository ppa:alexlarson/flatpak
	sudo apt update
	sudo apt install flatpak -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	#TODO: Add Flathub to AppCenter
}

########################################
# INSTALL BRAVE (CHROMIUM BROWSER)
########################################
function installChrome {
	milestone "INSTALL BRAVE (CHROMIUM PRIVACY BROWSER)"
	sudo apt install apt-transport-https curl gnupg -y
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser -y
}

########################################
# INSTALL CHROME REMOTE DESKTOP
########################################
function installChromeRemoteDesktop {
	milestone "INSTALL CHROME REMOTE DESKTOP"
	wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb -P /tmp
	sudo apt install /tmp/chrome-remote-desktop_current_amd64.deb
	/opt/google/chrome-remote-desktop/chrome-remote-desktop --stop
	sudo  mv /opt/google/chrome-remote-desktop/chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop.orig
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/chrome-remote-desktop -P /opt/google/chrome-remote-desktop
	/opt/google/chrome-remote-desktop/chrome-remote-desktop --start
	brave-browser-stable https://remotedesktop.google.com/access
}

########################################
# INSTALL GIT
########################################
function installGit {
	milestone "INSTALL GIT"
	sudo apt install git -y
	mkdir -p ~/Developer/Helium
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/.gitconfig -P ~
	wget -O ~/Developer/Helium/.gitconfig https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/.gitconfig-helium
}

########################################
# CREATE KEYS
########################################
function createKeys {
	milestone "CREATE KEYS"
	(bash github_pat.sh github.com https://github.com/settings/tokens &) 2>/dev/null

	#TODO: Create SSH Keys
}

########################################
# INSTALL PHP
########################################
function installPhp {
	#See https://www.tecmint.com/install-different-php-versions-in-ubuntu/
	milestone "INSTALL PHP"
	sudo add-apt-repository ppa:ondrej/php -y
	sudo apt install php7.4 -y
	sudo apt install php8.0 -y
	#sudo update-alternatives --set php /usr/bin/php8.0

	sudo apt install php7.4-mbstring
	sudo apt install php8.0-mbstring
	sudo apt install php7.4-curl
	sudo apt install php8.0-curl
	sudo apt install php7.4-dom
	sudo apt install php8.0-dom
	#TODO: Other extensions?

	#TODO: ini files
}

########################################
# INSTALL COMPOSER
########################################
function installComposer {
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	sudo mv composer.phar /usr/local/bin/composer
}

########################################
# INSTALL SPOTIFY
########################################
function installSpotify {
	milestone "INSTALL SPOTIFY"
	addHost "54.230.53.147" "repository.spotify.com"
	flatpak install https://dl.flathub.org/repo/appstream/com.spotify.Client.flatpakref -y
}

########################################
# SET DEFAULT APPS
########################################
function setDefaultApps {
	milestone "SET APP DEFAULTS"
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/mimeapps.list -P ~/.config
	#TODO
}

########################################
# RUN
########################################
#aptUpdate
#installFlatpak
#installChrome
#installChromeRemoteDesktop
#installGit
#createKeys
#setDefaultApps
#installSpotify
#installPhp
#installComposer
