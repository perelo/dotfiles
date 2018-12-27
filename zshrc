# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Path to my oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# themes can be found in ~/.oh-my-zsh/themes/
#ZSH_THEME="bira"

# plugins can be found in ~/.oh-my-zsh/plugins/
# custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

alias tmux="tmux -2" # force tmux 256 colors
alias rm="rm -i"     # ask confirmation
alias gds="git diff --staged"

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

# solaried with escape characters in Lxterminal
container=$(ps -h -o comm -p $pid $(ps -h -o ppid -p $$))
if [ "$container" = "lxterminal" ] && [ -f ~/.solarized/escchar_solarized.sh ]; then
    ~/.solarized/escchar_solarized.sh
fi

# bira ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
# copy from ~/.oh-my-zsh/themes/bira.zsh-themes w/o ruby stuff and RPS1 (used by vi-mode)
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
PROMPT="╭─${user_host} ${current_dir} ${git_branch}
╰─%B$%b "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

LESS=-RX # -X: don't clear screen before and after less

if [ -d "$HOME/local/bin" ] ; then
    PATH=$HOME/local/bin:$PATH
fi

if [ -d "/usr/local/texlive/2015/bin/x86_64-linux" ] ; then
    PATH=/usr/local/texlive/2015/bin/x86_64-linux/:$PATH
fi
