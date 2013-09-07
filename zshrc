# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Path to my oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# themes can be found in ~/.oh-my-zsh/themes/
ZSH_THEME="bira"

# plugins can be found in ~/.oh-my-zsh/plugins/
# custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

# force tmux 256 colors
alias tmux="tmux -2"

# Use 256 color terminal if it exists
if [ -e /lib/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# solarized-dark dircolors (ls colors)
if [ -e ~/.solarized/dircolors-solarized/dircolors.256dark ]; then
    eval `dircolors ~/.solarized/dircolors-solarized/dircolors.256dark`
fi
