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

if [ -d "/usr/local/texlive/2015/bin/x86_64-linux" ] ; then
    PATH=/usr/local/texlive/2015/bin/x86_64-linux/:$PATH
fi

export PATH="/home/eloi/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="/home/eloi/.gem/bin:$PATH"
export PATH="/home/eloi/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
