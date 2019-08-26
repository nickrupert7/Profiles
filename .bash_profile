### Set PATH
USER_PATHS=(
	/Library/Frameworks/Python.framework/Versions/3.7/bin
	~/.composer/vendor/bin
	/usr/local/mysql/bin
)
export PATH="$( IFS=$':'; echo "${USER_PATHS[*]}" ):$PATH"


### Git auto-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

### Bash Prompt
export PS1='\[\033[38;5;092m\]\W$(__git_ps1 " \[\033[38;5;135m\][%s]") \[\033[38;5;177m\]\$\e[39m '
