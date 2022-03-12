# If not running interactively, don't do anything
[ -z "$PS1" ] && return

EDITOR=vim
VISUAL=$EDITOR
MANPAGER="less"
export EDITOR VISUAL MANPAGER

HISTFILE="$HOME/.zsh_history"
SAVEHIST=100
setopt share_history
setopt extended_history

# Enable Ctrl-f to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

# load autocompletion
autoload -Uz compinit && compinit

if [ $HOST = "leto" ] ; then
    alias firefox="~/tools/firefox/firefox"
fi

VIMD=vimd
alias ls="ls --color=auto"
alias ll='ls -lsh --color=auto'
alias lla='ls -alsh --color=auto'
alias lls='ls -lshS --color=auto'
alias grep='grep --color=auto -i'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip -c'
alias rm="rm -i"            # ask confirmation
alias rename="rename -v"    # print names of files successfully renamed.
alias rsync="rsync --progress"

alias vi="vim"
alias vim="vim --servername $VIMD"
alias nvim="nvim --listen /tmp/nvimsocket"
alias tmux="env TERM=screen-256color tmux -2" # force tmux 256 colors
alias tma="tmux attach-session -t"
alias r="ranger"
alias rmswp="rm */.*.swp"

alias doci="docker image"
alias docc="docker container"

function amendpdf {
    if [ ${PWD} = "/home/eloi/workspace/topocap/redac/" ]; then
        rm -f chap-exact/chap-exact.pdf
        make chap-exact
        git add chap-exact/chap-exact.pdf
        git ci --amend
    else
        echo "nothing to be done"
    fi
}

function cheat {
    curl cheat.sh/$1
}

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

unset GREP_OPTIONS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/textidote/textidote.zsh ] && source /opt/textidote/textidote.zsh

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '$HOME/.netlify/helper/path.zsh.inc' ]; then source '$HOME/.netlify/helper/path.zsh.inc'; fi
