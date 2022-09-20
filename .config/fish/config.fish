# Set Aliases
alias rm='rm -I'
alias vi='nvim'
alias ipy='ipython'
alias dotfiles='/usr/bin/env git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias nix-shell='nix-shell --run fish'
alias nix-init='nix flake new -t github:nix-community/nix-direnv .'
alias idr='rlwrap -n -N idris2 -p contrib'
alias ls='exa --git --icons --time-style long-iso --group-directories-first'
alias df='duf'
alias htop='gtop'
alias cat='bat'

# Set Tensorflow log level lower
set -x TF_CPP_MIN_LOG_LEVEL 2

# Adjust path
fish_add_path /home/pinselimo/.nix-profile/bin/

# What
thefuck --alias | source

if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

# direnv
direnv hook fish | source

