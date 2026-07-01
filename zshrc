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

# Enable bash comments in the CLI (#)
setopt interactivecomments

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
alias diff='diff --color'
alias ip='ip -c'
alias rm="rm -i"            # ask confirmation
alias rename="rename -v"    # print names of files successfully renamed.
alias rsync="rsync --progress"
alias tree="tree -C"
alias diff="diff --color"
alias df="df -hT"           # "human", filesystem "Type"

alias t="tree -C"
alias vi="vim"
# alias nvim="nvim --listen /tmp/nvimsocket"
# alias nvim="/home/eloi/Documents/nvim-linux-x86_64/bin/nvim"
alias tma="tmux attach-session -t"

alias g="git"
alias dok="docker"
alias ku="kubectl"
alias tf="terraform"
alias plm="pulumi"

alias maude="maude -ansi-color"
alias kompiled="kompile --enable-llvm-debug"
alias krund="krun --debugger"

alias mermaid-cli-docker="docker run --rm -i -uroot -v./:/data minlag/mermaid-cli:11.15.0"

alias antlr4='java -Xmx500M -cp "/home/eloi/workspace/iac/playground/antlr-cue/parser/antlr-4.13.2-complete.jar:$CLASSPATH" org.antlr.v4.Tool'

# just make it work
alias nickel="docker run --rm -it ghcr.io/tweag/nickel:1.1.1"
alias gephi="~/Documents/gephi-0.10.1/bin/gephi"

function cheat {
    curl cheat.sh/$1
}

function acro {
    curl dict://dict.org/d:$1:vera
}

# https://gist.github.com/ahmed-musallam/27de7d7c5ac68ecbd1ed65b6b48416f9
function pdfcompress ()
{
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile=$1.compressed.pdf $1; 
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

[ -d /opt/nvim-linux-x86_64/bin/ ] && PATH=/opt/nvim-linux-x86_64/bin/:$PATH

# completion for various CLIs
for tool in  kubectl minikube helm cue holos #pulumi pulumictl
do
    if command -v $tool &> /dev/null
    then
        source <($tool completion zsh)
    fi
done
# Pkl completion -- deactivates shell completion :(
# if command -v 'pkl' &>/dev/null; then
#     source <(pkl shell-completion zsh)
# fi
# Nickel completion
if command -v 'pkl' &>/dev/null; then
    source <(nickel gen-completions zsh)
fi

# terraform CLI completion
if command -v 'terraform' &>/dev/null; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C terraform terraform
fi

# for rootless docker
# https://docs.docker.com/engine/security/rootless/#prerequisites
export DOCKER_HOST=unix:///run/user/1000/docker.sock
# export DOCKER_HOST=unix:///run/docker.sock

# # >>>> Vagrant command completion (start)
# fpath=(/usr/share/rubygems-integration/all/gems/vagrant-2.2.14/contrib/zsh $fpath)
# compinit
# # <<<<  Vagrant command completion (end)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/eloi/google-cloud-sdk/path.zsh.inc' ]; then . '/home/eloi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/eloi/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/eloi/google-cloud-sdk/completion.zsh.inc'; fi

# Pycharm installation home
if [ -d '/home/eloi/Documents/pycharm-2025.3.3' ]; then PATH=$PATH:'/home/eloi/Documents/pycharm-2025.3.3/bin'; fi

# Nomad autocomplete
if [ -f '/usr/bin/nomad' ]; then complete -o nospace -C /usr/bin/nomad nomad; fi
