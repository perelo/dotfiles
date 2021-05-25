emulate sh -c 'source ~/.profile'

if [ -d "$HOME/go/bin" ] ; then
    PATH=$HOME/go/bin:$PATH
fi

if [ -d "/usr/local/go/bin/" ] ; then
    PATH=/usr/local/go/bin:$PATH
fi

if [ -d "$HOME/.local/texlive/2020/bin/x86_64-linux/" ] ; then
    PATH=~/.local/texlive/2020/bin/x86_64-linux/:$PATH
fi

if command -v pyenv &> /dev/null
then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if command -v rbenv &> /dev/null
then
    export PATH="$HOME/.gem/bin:$PATH"
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
