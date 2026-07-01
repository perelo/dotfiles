dotfiles
========

My GNU/Linux environment

Installation
------------

## Download everything

    git clone https://github.com/perelo/dotfiles.git
    cd dotfiles
    git submodule init
    git submodule update
    sudo apt install \
        vim-gtk3
        zsh \
        tmux \
        xsel \
        fonts-font-awesome \
        pulseaudio-utils \

## Install fzf

    cd fzf
    ./install

## Add vim's tmp and swap directory

    mkdir -p ~/.vim/tmp/swap/
    mkdir -p ~/.vim/tmp/undo/

## Backup old dotfiles and install new ones

    python3 links.py

## Permanently change your shell to `zsh`

    chsh -s /bin/zsh

## terminfo compile

    tic ~/dotfiles/screen-256color.terminfo

## LaTeX setup

    sudo apt install rubber
    tlmgr init-usertree
    tlmgr update -all

For updates, see https://tug.org/texlive/upgrade.html

## Note

* vim's `UltiSnips` plugin requires Python's `unidecode` :

    `pip install unidecode`

* i3 python dependencies

    python3 -m venv ~/dotfiles/config/i3/
    ~/dotfiles/config/i3/bin/pip3 install i3ipc fontawesome autotiling


* i3 with gnome flashback: https://github.com/schoppmp/i3-gnome-flashback

* gsettings
  * `gsettings set org.gnome.gnome-flashback status-notifier-watcher true` for tray icons.
  * `gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"`
