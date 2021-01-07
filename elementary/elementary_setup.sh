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
	apt update
	apt upgrade -y
	apt install software-properties-common -y
	apt update
}

########################################
# APT UPDATE
########################################
function installProfiles {
	milestone "INSTALL PROFILES"
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/.bash_profile -O ~/.bash_profile
	chown nick:nick ~/.bash_profile

	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/.nanorc -O ~/.nanorc
	chown nick:nick ~/.nanorc
}

########################################
# INSTALL SNAP
########################################
function installSnap {
	apt install snapd -y
}

########################################
# INSTALL FLATPAK
########################################
function installFlatpak {
	milestone "INSTALL FLATPAK"
	add-apt-repository ppa:alexlarson/flatpak -y
	apt update
	apt install flatpak -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	#TODO: Add Flathub to AppCenter
}

########################################
# INSTALL BRAVE (CHROMIUM BROWSER)
########################################
function installChrome {
	milestone "INSTALL BRAVE (CHROMIUM PRIVACY BROWSER)"
	apt install apt-transport-https curl gnupg -y
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
	apt update
	apt install brave-browser -y
}

########################################
# INSTALL CHROME REMOTE DESKTOP
########################################
function installChromeRemoteDesktop {
	milestone "INSTALL CHROME REMOTE DESKTOP"
	wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb -P /tmp
	apt install /tmp/chrome-remote-desktop_current_amd64.deb
	/opt/google/chrome-remote-desktop/chrome-remote-desktop --stop
	 mv /opt/google/chrome-remote-desktop/chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop.orig
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/chrome-remote-desktop -P /opt/google/chrome-remote-desktop
	/opt/google/chrome-remote-desktop/chrome-remote-desktop --start
	brave-browser-stable https://remotedesktop.google.com/access
}

########################################
# INSTALL GIT
########################################
function installGit {
	milestone "INSTALL GIT"
	apt install git -y

	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/.gitconfig -P ~
	chown nick:nick ~/.gitconfig

	mkdir -p ~/Developer/Helium
	wget -O ~/Developer/Helium/.gitconfig https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/.gitconfig-helium
	chown nick:nick ~/Developer/Helium/.gitconfig-helium

	apt-get install git-core bash-completion -y

	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-tree -O /usr/local/bin/git-tree
	chmod +x /usr/local/bin/git-tree
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-trim -O /usr/local/bin/git-trim
	chmod +x /usr/local/bin/git-trim
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/git-update -O /usr/local/bin/git-update
	chmod +x /usr/local/bin/git-update
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
	add-apt-repository ppa:ondrej/php -y
	apt install php7.4 -y
	apt install php8.0 -y
	#update-alternatives --set php /usr/bin/php8.0

	apt install php7.4-mbstring
	apt install php8.0-mbstring
	apt install php7.4-curl
	apt install php8.0-curl
	apt install php7.4-dom
	apt install php8.0-dom
	#TODO: Other extensions?

	sed -i 's/memory_limit =.*/memory_limit = -1/g' /etc/php/7.4/cli/php.ini
	sed -i 's/memory_limit =.*/memory_limit = -1/g' /etc/php/8.0/cli/php.ini
}

########################################
# INSTALL COMPOSER
########################################
function installComposer {
	milestone "INSTALL COMPOSER"
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	mv composer.phar /usr/local/bin/composer

	composer global require laravel/installer
}

########################################
# INSTALL DOCKER
########################################
function installDocker {
	milestone "INSTALL DOCKER"
	sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -csu) stable" -y
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io -y
}

########################################
# INSTALL ATOM
########################################
function installAtom {
	milestone "INSTALL ATOM"
	flatpak install flathub io.atom.Atom --system -y
}

########################################
# INSTALL PHPSTORM
########################################
function installPhpStorm {
	milestone "INSTALL PHPSTORM"
	flatpak install flathub com.jetbrains.PhpStorm --system -y
}

########################################
# INSTALL POSTMAN
########################################
function installPostman {
	milestone "INSTALL POSTMAN"
	flatpak install flathub com.getpostman.Postman --system -y
}

########################################
# INSTALL ANDROID MESSAGES
########################################
function installAndroidMessages {
	milestone "INSTALL ANDROID MESSAGES"
	URL=$(curl -s https://api.github.com/repos/chrisknepper/android-messages-desktop/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep .deb | head -n 1)
	wget $URL -O /tmp/android_messages.deb
	sudo apt install /tmp/android_messages.deb -y
}

########################################
# INSTALL SLACK
########################################
function installSlack {
	milestone "INSTALL SLACK"
	flatpak install flathub com.slack.Slack --system -y
}

########################################
# INSTALL SPOTIFY
########################################
function installSpotify {
	milestone "INSTALL SPOTIFY"
	addHost "54.230.53.147" "repository.spotify.com"
	flatpak install flathub com.spotify.Client --system -y
}

########################################
# SET PREFERENCES
########################################
function setPreferences {
	milestone "SET PREFERENCES"
	#TODO: Finish mimeapps.list
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/mimeapps.list -P ~/.config
	chown nick:nick ~/.config/mimeapps.list
	gsettings set io.elementary.desktop.wingpanel.datetime clock-show-seconds true
	gsettings set org.gnome.desktop.peripherals.keyboard repeat true

	# Set Dock Applications
	# When adding items in the future, it is important to add each launch
  # in the order it should appear in the Dock
	mkdir /tmp/launchers
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/launchers/io.elementary.files.dockitem -P /tmp/launchers
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/launchers/brave-browser.dockitem -P /tmp/launchers
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/launchers/org.pantheon.mail.dockitem -P /tmp/launchers
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/launchers/com.spotify.Client.dockitem -P /tmp/launchers
	wget https://raw.githubusercontent.com/nickrupert7/Profiles/master/elementary/launchers/io.elementary.terminal.dockitem -P /tmp/launchers
	rm -rf ~/.config/plank/dock1/launchers
	mv /tmp/launchers ~/.config/plank/dock1
	chown -R nick:nick ~/.config/plank/dock1/launchers
	killall plank
	su - nick -c "nohup plank &"

	# Remap Super Key
	gsettings set org.gnome.mutter overlay-key ''
	gsettings set org.pantheon.desktop.gala.behavior overlay-action ''
	snap install ksuperkey
	ksuperkey -e 'Super_L=Super_L|Down'
}

########################################
# RUN
########################################
#aptUpdate
#installProfiles
#installSnap
#installFlatpak
#installChrome
#installChromeRemoteDesktop
#installGit
#createKeys
#installPhp
#installComposer
#installDocker
#installAtom
#installPhpStorm
#installPostman
#installAndroidMessages
#installSlack
#installSpotify
setPreferences
#milestone $'FINISHED\nWhen you are ready, plese restart your computer\nfor configuration settings to take effect'
