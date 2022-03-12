#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
"""

__author__ = 'eloi'
__date__ = '10-07-2019'

import os
import shutil
from pathlib import Path

# paths must be absolute
dotfiles = Path.cwd()
dotfiles_old = Path.home() / 'dotfiles_old'
config = Path.home() / '.config'
config_old = dotfiles_old / 'config'

# print(dotfiles_old.absolute().name)
# print(config)
# print(config_old)

# list of items to link in $HOME preceeded by '.'
items = [
    "vimrc",
    "vim/",
    "zshrc",
    "zsh/",
    "tmux.conf",
    "tmuxcolors-base16.conf",
    "gitconfig",
    "gitignore",
    "ctags",
]

# list of items to link in $config
confitems = [
    "gnome-session/",
    "i3/",
    "lxterminal/",
    "polybar/",
    "base16-shell/",
    "rofi/",
]

# create dotfiles_old directory for backups
print('Creating backup directories '+dotfiles_old.name+' and '+config_old.name)
os.mkdir(str(dotfiles_old))
os.mkdir(str(config_old))

# do the deed
for item in items:
    src = dotfiles / item
    dst = Path.home() / Path('.' + item)
    if dst.exists():
        dst.rename(dotfiles_old / dst.name)
        print("backup " + str(dst) + ' -> ' + str(dotfiles_old/dst.name))
    dst.symlink_to(src)
    print(str(src) + ' -> ' + str(dst))

for item in confitems:
    src = dotfiles / 'config' / item
    dst = config / item
    if dst.exists():
        dst.rename(config_old / dst.name)
        print("backup " + str(dst) + ' -> ' + str(config_old/dst.name))
    dst.symlink_to(src)
    print(str(dst) + ' link to ' + str(src))
