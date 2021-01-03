host=$1
settingsLink=$2

xdg-open $settingsLink &>/dev/null

username=$(zenity --forms\
	--title="Git Username"\
	--text="Enter your username for $host"\
	--add-entry="Username"
	2>/dev/null)

token=$(zenity --forms\
	--title="Git Personal Access Token"\
	--text="Please create a new Personal Access Token for $host, then enter it here "\
	--add-password="Token"
	2>/dev/null)

sed -i "/$host/d" ~/.git-credentials
echo "https://$username:$token@$host" >> ~/.git-credentials

zenity --info\
	--text="Your credentials were successfully added to the local git configuration"
	2>/dev/null
