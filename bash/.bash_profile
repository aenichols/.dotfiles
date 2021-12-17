# generated by Git for Windows
# test -f ~/.profile && . ~/.profile
# test -f ~/.bashrc && . ~/.bashrc

export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"

PERSONAL=$XDG_CONFIG_HOME/personal
source $PERSONAL/env
for i in `find -L $PERSONAL | grep ".*personal/.*"`; do
    source $i
done

# ls
alias la="ls -la"
alias ls="ls -F --color=auto --show-control-chars"

# mock cli ¯\_(ツ)_/¯ works
alias identity="$HOME/work/my_cli/identity/myidentity"
alias qp="$HOME/work/my_cli/quickerpay/myquickerpay"

# startup
alias startw="$HOME/.dotfiles-windows/rooster/sw"
alias opera="$HOME/AppData/Local/Programs/Opera/opera.exe"
alias teams="$HOME/AppData/Local/Microsoft/Teams/current/Teams.exe"
alias outlook="/C/Program Files/Microsoft Office/root/Office16/Outlook.exe"
alias obsidian="$HOME/AppData/Local/Obsidian/Obsidian.exe"
