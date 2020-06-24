### Paths
PATHS=(
	./vendor/bin/
)

export PATH="$PATH:$( IFS=$':'; echo "${PATHS[*]}" )"
export PYTHONPATH=/usr/local/lib/python3.7/site-packages:$PYTHONPATH
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig"

### Flags
export BASH_SILENCE_DEPRECATION_WARNING=1
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include -I/usr/local/opt/libxml2/include"

### Git auto-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

### Bash Prompt
export PS1='\[\033[38;5;092m\]\W$(__git_ps1 " \[\033[38;5;135m\][%s]") \[\033[38;5;177m\]\$\[\033[38;5;255m\] '

### Aliases
alias pa="php artisan"
alias gs="git status"
alias gl="git log"
alias gu="git update"
alias gp="git pull"
alias gr="git rebase"
alias grc="git rebase --continue"
alias grm="git rebase master"
alias grh="git reset --hard"
alias gc="git commit"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gp="git push"
