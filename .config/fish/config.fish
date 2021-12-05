set fish_greeting 
set -gx EDITOR nvim
set NIX_LINK $HOME/.nix-profile
starship init fish | source

set PATH "$HOME/.cargo/bin:$PATH"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
