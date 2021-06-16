# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/pinselimo/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

alias rm='rm -i'
alias ipy='ipython'
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias android-studio='STUDIO_JDK=/usr/lib/jvm/java-11-openjdk-amd64/ /opt/android-studio/bin/studio.sh'

set -x MOZ_ENABLE_WAYLAND 1
set -x TF_CPP_MIN_LOG_LEVEL 2
set -x JAVA_HOME "/usr"
set -x _JAVA_AWT_WM_NONREPARENTING 1

fish_add_path /home/pinselimo/.local/bin/
fish_add_path /home/pinselimo/.cabal/bin/
fish_add_path /home/pinselimo/.cargo/bin/
fish_add_path /home/pinselimo/.dynamic-colors/bin/
fish_add_path /home/pinselimo/anaconda3/bin/
