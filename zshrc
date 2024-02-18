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

alias ls="ls --color=auto"
alias ll='ls -klsh --color=auto'
alias lla='ls -kalsh --color=auto'
alias lls='ls -lshS --color=auto'
alias grep='grep --color=auto -i'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip -c'
alias rm="rm -i"            # ask confirmation
alias rename="rename -v"    # print names of files successfully renamed.
alias rsync="rsync --progress"
alias tree="tree -C"
alias df="df -hT"           # "human", filesystem "Type"

alias vi="vim"
alias nvim="nvim --listen /tmp/nvimsocket"
alias tma="tmux attach-session -t"
alias r="ranger"
alias rmswp="rm */.*.swp"

alias dok="docker"
alias ku="kubectl"
alias tf="terraform"

alias kompiled="kompile --enable-llvm-debug"
alias krund="krun --debugger"

# just make it work
alias nickel="docker run --rm -it ghcr.io/tweag/nickel:1.1.1"
alias gephi="~/Documents/gephi-0.10.1/bin/gephi"

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

# https://github.com/romkatv/gitstatus
if [ -f $HOME/.zsh/gitstatus/gitstatus.prompt.zsh ]; then
    source $HOME/.zsh/gitstatus/gitstatus.prompt.zsh
    RPROMPT='$GITSTATUS_PROMPT'
fi

# bira theme from
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~ %{$reset_color%}'
PROMPT="╭─${user_host}${current_dir}
╰─%B$%b "

LESS=-RX # -X: don't clear screen before and after less

unset GREP_OPTIONS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/textidote/textidote.zsh ] && source /opt/textidote/textidote.zsh

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '$HOME/.netlify/helper/path.zsh.inc' ]; then source '$HOME/.netlify/helper/path.zsh.inc'; fi

# completion for various CLIs
for tool in  kubectl minikube helm cue
do
    if command -v $tool &> /dev/null
    then
        source <($tool completion zsh)
    fi
done

# terraform CLI completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C terraform terraform

# for rootless docker
# https://docs.docker.com/engine/security/rootless/#prerequisites
export DOCKER_HOST=unix:///run/user/1000/docker.sock

# # >>>> Vagrant command completion (start)
# fpath=(/usr/share/rubygems-integration/all/gems/vagrant-2.2.14/contrib/zsh $fpath)
# compinit
# # <<<<  Vagrant command completion (end)
