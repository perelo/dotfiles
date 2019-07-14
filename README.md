dotfiles
========

My GNU/Linux environment

* vim
* zsh
* tmux
* gnome-terminal

Installation
------------

### Download everything

    git clone https://github.com/perelo/dotfiles.git
    cd dotfiles
    git submodule init
    git submodule update

## Install fzf

    cd fzf
    ./install

### Backup old dotfiles and install new ones

    ./makelinks.sh

## Set solarized dark colors

## for `gnome-terminal`

    ./solarized/gnome-terminal-colors-solarized/set_dark.sh

## for `lxterminal`

    cp ~/dotfiles/config ~/.config

### Permanently change your shell to `zsh`

    chsh -s /bin/zsh

### terminfo compile

    tic ~/dotfiles/screen-256color.terminfo
### Note

* vim's `UltiSnips` plugin requires Python's `unidecode` :

    `pip install unidecode`
