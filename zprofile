emulate sh -c 'source ~/.profile'

if [ -d "$HOME/.local/bin/" ] ; then
    PATH=$HOME/.local/bin:$PATH
fi

# Dhall language
if [ -d "$HOME/.local/dhall/" ] ; then
    PATH=$HOME/.local/dhall/bin:$PATH
fi

if [ -d "$HOME/.local/go/bin" ] ; then
    PATH=$HOME/.local/go/bin:$PATH
fi

if [ -d "/usr/local/go/bin" ] ; then
    PATH=/usr/local/go/bin:$PATH
fi

# usual GOPATH
if [ -d "$HOME/go/bin" ] ; then
    PATH=$HOME/go/bin:$PATH
    GOPATH=$HOME/go
fi

PATH=~/.local/texlive/2023/bin/x86_64-linux:$PATH
MANPATH=~/.local/texlive/2023/texmf-dist/doc/man:$MANPATH

if [ -d "~/.local/texlive/2023/bin/x86_64-linux/" ] ; then
    PATH=/usr/local/texlive/2023/bin/x86_64-linux/:$PATH
fi
if [ -d "/usr/local/texlive/2023/texmf-dist/doc/man" ] ; then
    MANPATH=/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH
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

if [ -d "$HOME/.local/share/coursier/bin" ] ; then
    export PATH=$HOME/.local/share/coursier/bin:$PATH
fi
