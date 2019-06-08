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

### Note
* If you want to use `vim` inside `tmux` with the right colors (in a terminal which supports 256 colors), make sure you have the right value of `TERM` before launching `tmux`.
  Note that `.zshrc` already export this variable correctly.

    `export TERM=xterm-256color`


* The size of everything (with submodules) is 9.6Mo.

* vim's `UltiSnips` plugin requires Python's `unidecode` :

    `pip install unidecode`
