set fish_greeting 

set -gx EDITOR nvim

set NIX_LINK $HOME/.nix-profile

starship init fish | source

set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/node_modules/tree-sitter-cli:$PATH"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
