token=$(zenity --forms\
	--title="GitHub Personal Access Token"\
	--text="Please create a new GitHub Personal Access Token, then enter it here "\
	--add-password="Token" 2>/dev/null)

echo "https://nickrupert7:$token@github.com" > ~/.git-credentials
