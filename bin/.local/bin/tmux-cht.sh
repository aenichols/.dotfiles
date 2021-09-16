#!/usr/bin/env bash
selected=`cat $DOTFILES/tmux/.tmux-cht-languages $DOTFILES/tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" $DOTFILES/tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    bash -c "curl -s cht.sh/$selected~$query | less"
fi

