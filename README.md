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

    python3 links.py

### Permanently change your shell to `zsh`

    chsh -s /bin/zsh

### terminfo compile

    tic ~/dotfiles/screen-256color.terminfo

### Note

* vim's `UltiSnips` plugin requires Python's `unidecode` :

    `pip install unidecode`
