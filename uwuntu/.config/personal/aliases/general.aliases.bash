# shellcheck shell=bash
if command ls --color -d . &> /dev/null; then
	alias ls='ls --color=auto'
	# BSD `ls` doesn't need an argument (`-G`) when `$CLICOLOR` is set.
fi

# List directory contents
alias ls="ls -F --color=auto --show-control-chars"
alias sl=ls
alias la='ls -al'
alias ll='ls -A' # Compact view, show hidden
alias l='ls -a'
alias l1='ls -1'

alias _='sudo'

# Shortcuts to edit startup files
alias vbrc='${VISUAL:-vim} ~/.bashrc'
alias vbpf='${VISUAL:-vim} ~/.bash_profile'

# colored grep
# Need to check an existing file for a pattern that will be found to ensure
# that the check works when on an OS that supports the color option
alias grep='grep --color=auto'

alias c='clear'
alias cls='clear'

alias edit='${EDITOR:-${ALTERNATE_EDITOR:-nano}}'
alias pager='${PAGER:=less}'

alias q='exit'

alias irc='${IRC_CLIENT:=irc}'

# Language aliases
alias rb='ruby'
alias py='python'
alias ipy='ipython'

# Pianobar can be found here: http://github.com/PromyLOPh/pianobar/
alias piano='pianobar'

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Shell History
alias h='history'

# Tree
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# Directory
alias md='mkdir -p'
alias rd='rmdir'

# Shorten extract
alias xt='extract'

# Display whatever file is regular file or folder
function catt() {
	for i in "$@"; do
		if [[ -d "$i" ]]; then
			ls "$i"
		else
			cat "$i"
		fi
	done
}
