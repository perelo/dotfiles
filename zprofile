emulate sh -c 'source ~/.profile'

if [ -d "$HOME/.local/bin" ] ; then
    PATH=$HOME/.local/bin:$PATH
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH=$HOME/go/bin:$PATH
fi

if [ -d "/usr/local/go/bin/" ] ; then
    PATH=/usr/local/go/bin:$PATH
fi

if [ -d "/usr/local/texlive/2020/bin/x86_64-linux/" ] ; then
    PATH=/usr/local/texlive/2020/bin/x86_64-linux/:$PATH
fi

if command -v pyenv &> /dev/null
then
    export PATH="/home/eloi/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if command -v rbenv &> /dev/null
then
    export PATH="/home/eloi/.gem/bin:$PATH"
    export PATH="/home/eloi/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
