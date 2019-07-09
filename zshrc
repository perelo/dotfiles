# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Path to my oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

EDITOR=vim
VISUAL=$EDITOR
export EDITOR VISUAL

# themes can be found in ~/.oh-my-zsh/themes/
#ZSH_THEME="bira"

# plugins can be found in ~/.oh-my-zsh/plugins/
# custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

VIMD=vimd
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -l'
alias lal='ls -al'
alias vi="vim"
alias vim="vim --servername $VIMD"
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias tmux="env TERM=screen-256color tmux -2" # force tmux 256 colors
alias rm="rm -i"     # ask confirmation
alias tma="tmux attach-session -t"
alias r="ranger"
alias rmswp="rm */.*.swp"

export MANPAGER="nvim -c 'set ft=man' -"

function acro {
    curl dict://dict.org/d:$1:vera
}

alias doci="docker image"
alias docc="docker container"

# # Use 256 color terminal if it exists
# if [ -e /lib/terminfo/x/xterm-256color ]; then
#     export TERM='xterm-256color'
# else
#     export TERM='xterm-color'
# fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


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

if [ -d "$HOME/.local/bin" ] ; then
    PATH=$HOME/.local/bin:$PATH
fi

if [ -d "/usr/local/texlive/2015/bin/x86_64-linux" ] ; then
    PATH=/usr/local/texlive/2015/bin/x86_64-linux/:$PATH
fi

unset GREP_OPTIONS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
