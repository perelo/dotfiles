#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory

# list of files/folders to symlink in homedir (all except README.md and this script)
n=`basename $0`
files=`ls $dir | sed -e "/README.md\|$n/d"`

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo -en "$file\t: Backing up old .$file..."
    mv ~/.$file ~/dotfiles_old/ 2>/dev/null
    echo -en "done\tCreating symlink..."
    ln -s $dir/$file ~/.$file
    echo "done"
done
