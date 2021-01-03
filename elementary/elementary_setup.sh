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
	brave-browser-stable https://github.com/settings/tokens --no-sandbox
	(bash github_pat.sh &) 2>/dev/null
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
}

########################################
# RUN
########################################
#aptUpdate
#installFlatpak
#installChrome
#installChromeRemoteDesktop
#installGit
createKeys
#setDefaultApps
#installSpotify
