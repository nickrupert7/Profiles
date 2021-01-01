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
# CREATE DEVELOPER DIRECTORY
########################################
function createDeveloperDirectory {
	milestone "CREATE DEVELOPER DIRECTORY"
	mkdir ~/Developer
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
# INSTALL GIT
########################################
function installGit {
	sudo apt install git -y
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
	
	/opt/google/chrome-remote-desktop/chrome-remote-desktop --start
}

########################################
# RUN
########################################
#aptUpdate
#installFlatpak
#installGit
#installSpotify
installChrome