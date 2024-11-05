#!/usr/bin/env bash



clone_dir=~/file_system_script/

#Symbolic link for config files

#symlink bin
# If the directory ~/bin doesn't exist, create the directory, else echo already exist.
if [ ! -d ~/bin ];
then
  mkdir -p ~/bin # -p creates the directory if it doesn't exist and avoids error message if it exists
  ln -s $clone_dir/bin/sayhi ~/bin/sayhi
  ln -s $clone_dir/bin/install-fonts ~/bin/install-fonts
  echo "~/bin directory created and symlinks connected"
else
  echo "~/bin directory already exists, updating symlink"
  ln -s $clone_dir/bin/sayhi ~/bin/sayhi
  ln -s $clone_dir/bin/install-fonts ~/bin/install-fonts
fi


#symlink config
if [ ! -d ~/.config/kak/kakrc ];
then
  mkdir -p ~/.config/kak
  ln -s $clone_dir/config/kak/kakrc ~/.config/kak/kakrc
  echo "~/.config/kak/kakrc directory created and symlink connected"
else
  echo "~/.config/kak/kakrc already exists, updating symlink"
  ln -s $clone_dir/config/kak/kakrc ~/.config/kak/kakrc
fi

if [ ! -d ~/.config/tmux/tmux.conf ];
then
  mkdir -p ~/.config/tmux
  ln -s $clone_dir/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
  echo "~/.config/tmux/tmux.conf directory created and symlink connected"
else
  echo "~/.config/tmux/tmux.conf already exists, updating symlink"
  ln -s $clone_dir/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
fi

#symlink home
ln -s $clone_dir/home/bashrc ~/.bashrc