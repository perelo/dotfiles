# If not running interactively, don't do anything
[ -z "$PS1" ] && return

EDITOR=vim
VISUAL=$EDITOR
MANPAGER="nvim -c 'set ft=man' -"
export EDITOR VISUAL MANPAGER

# load autocompletion
autoload -Uz compinit && compinit

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

alias doci="docker image"
alias docc="docker container"


function acro {
    curl dict://dict.org/d:$1:vera
}

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


autoload -U colors && colors
setopt prompt_subst

# bira theme from
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~ %{$reset_color%}'
PROMPT="╭─${user_host}${current_dir}
╰─%B$%b "

# git-prompt from
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git-prompt
source $HOME/.zsh/git-prompt/git-prompt.plugin.zsh
RPROMPT='$(git_super_status)'


LESS=-RX # -X: don't clear screen before and after less

if [ -d "$HOME/.local/bin" ] ; then
    PATH=$HOME/.local/bin:$PATH
fi

if [ -d "/usr/local/texlive/2015/bin/x86_64-linux" ] ; then
    PATH=/usr/local/texlive/2015/bin/x86_64-linux/:$PATH
fi

unset GREP_OPTIONS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
