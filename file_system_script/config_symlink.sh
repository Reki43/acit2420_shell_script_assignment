#!/usr/bin/env bash

clone_dir=~/acit2420_shell_script/file_system_script/2420-as2-starting-files

# Symbolic link for config files

# symlink bin
# Check if ~/bin doesn't exist. If it doesn't created the bin dir, else, say it already exist.
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
  echo "~/bin directory created"
else
  echo "~/bin directory already exists"
fi

# Check if the symlink exist with -L option. If it exist, say it exist, else symlink the two and say it has been created.
if [ -L ~/bin/sayhi ]; then
  echo "Symlink ~/bin/sayhi already exists"
else
  ln -s $clone_dir/bin/sayhi ~/bin/sayhi
  echo "Symlink ~/bin/sayhi created"
fi

if [ -L ~/bin/install-fonts ]; then
  echo "Symlink ~/bin/install-fonts already exists"
else
  ln -s $clone_dir/bin/install-fonts ~/bin/install-fonts
  echo "Symlink ~/bin/install-fonts created"
fi


# symlink config for kak
# Check if ~/.config/kak doesn't exist. If it doesn't created the .config/kak dir, else, say it already exist.
if [ ! -d ~/.config/kak ]; then
  mkdir -p ~/.config/kak
  echo "~/.config/kak directory created"
else
  echo "~/.config/kak directory already exists"
fi


# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L ~/.config/kak/kakrc ]; then
  echo "Symlink ~/.config/kak/kakrc already exists"
else
  ln -s $clone_dir/config/kak/kakrc ~/.config/kak/kakrc
  echo "Symlink ~/.config/kak/kakrc created"
fi

# symlink config for tmux
# Check if ~/.config/tmux doesn't exist. If it doesn't created the .config/tmux dir, else, say it already exist.
if [ ! -d ~/.config/tmux ]; then
  mkdir -p ~/.config/tmux
  echo "~/.config/tmux directory created"
else
  echo "~/.config/tmux directory already exists"
fi

# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L ~/.config/tmux/tmux.conf ]; then
  echo "Symlink ~/.config/tmux/tmux.conf already exists"
else
  ln -s $clone_dir/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
  echo "Symlink ~/.config/tmux/tmux.conf created"
fi

# symlink home bashrc
# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L ~/.bashrc ]; then
  echo "Symlink ~/.bashrc already exists"
else
  ln -s $clone_dir/home/bashrc ~/.bashrc
  echo "Symlink ~/.bashrc created"
fi
