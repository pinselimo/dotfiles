# Set Aliases
alias rm='rm -I'
alias vi='nvim'
alias ipy='ipython'
alias dotfiles='/usr/bin/env git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias nix-shell='nix-shell --run fish'
alias nix-init='nix flake new -t github:nix-community/nix-direnv .'
alias idr='rlwrap -n -N idris2 -p contrib'
alias ls='eza --git --icons --time-style long-iso --group-directories-first'
alias df='duf'
alias htop='gtop'
alias cat='bat'
alias flake-shell='nix develop --command fish'
alias fvi='nix develop --command vi'
alias fnotebook='nix develop --command jupyter notebook'

# Set Tensorflow log level lower
set -x TF_CPP_MIN_LOG_LEVEL 2

# Adjust path
fish_add_path /home/pinselimo/.nix-profile/bin/

# What
thefuck --alias | source

# direnv
direnv hook fish | source

