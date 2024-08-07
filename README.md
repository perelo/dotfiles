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

### Add vim's tmp and swap directory

    mkdir -p ~/.vim/tmp/swap/
    mkdir -p ~/.vim/tmp/undo/

### Backup old dotfiles and install new ones

    python3 links.py

### Permanently change your shell to `zsh`

    chsh -s /bin/zsh

### terminfo compile

    tic ~/dotfiles/screen-256color.terminfo

### Note

* vim's `UltiSnips` plugin requires Python's `unidecode` :

    `pip install unidecode`

* i3 python dependencies

    python3 -m venv ~/dotfiles/config/i3/
    ~/dotfiles/config/i3/bin/pip3 install i3ipc fontawesome autotiling

* dconf
  * `org.gnome.gnome-flashback status-notifier-watcher` for tray icons.
