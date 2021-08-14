set fish_greeting 
set -gx EDITOR nvim
starship init fish | source

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
