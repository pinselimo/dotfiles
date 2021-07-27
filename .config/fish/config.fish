# Set Aliases
alias rm='rm -I'
alias vi='nvim'
alias ipy='ipython'
alias dotfiles='/usr/bin/env git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias nix-shell='nix-shell --run fish'
alias android-studio='STUDIO_JDK=/usr/lib/jvm/java-11-openjdk-amd64/ /opt/android-studio/bin/studio.sh'
alias se='TERM=xterm sudo -e'

# Set Tensorflow log level lower 
set -x TF_CPP_MIN_LOG_LEVEL 2

# Adjust path
#fish_add_path /home/pinselimo/.local/bin/
fish_add_path /home/pinselimo/.dynamic-colors/bin/
fish_add_path /home/pinselimo/.nix-profile/bin/

# What
thefuck --alias | source

if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end
