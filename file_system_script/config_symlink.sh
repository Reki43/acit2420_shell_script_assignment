#!/usr/bin/env bash

# Determine the original user's home directory
if [ "$SUDO_USER" ];
then
  # If the script is run with sudo, set USER_HOME to the home directory of the user who invoked sudo
  USER_HOME="/home/$SUDO_USER"
  echo "Script is being run with sudo by user $SUDO_USER"
else
  # If not run with sudo, set USER_HOME to the current user's home directory
  USER_HOME=$HOME
  echo "Script is being run by the current user $USER"
fi


clone_dir=$USER_HOME/acit2420_shell_script/file_system_script/2420-as2-starting-files

# Symbolic link for config files

# symlink bin
# Check if $USER_HOME/bin doesn't exist. If it doesn't created the bin dir, else, say it already exist.
if [ ! -d $USER_HOME/bin ]; then
  mkdir -p $USER_HOME/bin
  echo "/bin directory created"
else
  echo "/bin directory already exists"
fi

# Check if the symlink exist with -L option. If it exist, say it exist, else symlink the two and say it has been created.
if [ -L $USER_HOME/bin/sayhi ]; then
  echo "Symlink $USER_HOME/bin/sayhi already exists"
else
  ln -s $clone_dir/bin/sayhi $USER_HOME/bin/sayhi
  echo "Symlink $USER_HOME/bin/sayhi created"
fi

if [ -L $USER_HOME/bin/install-fonts ]; then
  echo "Symlink $USER_HOME/bin/install-fonts already exists"
else
  ln -s $clone_dir/bin/install-fonts $USER_HOME/bin/install-fonts
  echo "Symlink $USER_HOME/bin/install-fonts created"
fi

# symlink config for kak
# Check if $USER_HOME/.config/kak doesn't exist. If it doesn't created the .config/kak dir, else, say it already exist.
if [ ! -d $USER_HOME/.config/kak ]; then
  mkdir -p $USER_HOME/.config/kak
  echo "/.config/kak directory created"
else
  echo "/.config/kak directory already exists"
fi

# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L $USER_HOME/.config/kak/kakrc ]; then
  echo "Symlink $USER_HOME/.config/kak/kakrc already exists"
else
  ln -s $clone_dir/config/kak/kakrc $USER_HOME/.config/kak/kakrc
  echo "Symlink $USER_HOME/.config/kak/kakrc created"
fi

# symlink config for tmux
# Check if $USER_HOME/.config/tmux doesn't exist. If it doesn't created the .config/tmux dir, else, say it already exist.
if [ ! -d $USER_HOME/.config/tmux ]; then
  mkdir -p $USER_HOME/.config/tmux
  echo "/.config/tmux directory created"
else
  echo "/.config/tmux directory already exists"
fi

# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L $USER_HOME/.config/tmux/tmux.conf ]; then
  echo "Symlink $USER_HOME/.config/tmux/tmux.conf already exists"
else
  ln -s $clone_dir/config/tmux/tmux.conf $USER_HOME/.config/tmux/tmux.conf
  echo "Symlink $USER_HOME/.config/tmux/tmux.conf created"
fi

# symlink home bashrc
# If symlink exist, say it exist, else symlink the two and say it has been created.
if [ -L $USER_HOME/.bashrc ]; then
  echo "Symlink $USER_HOME/.bashrc already exists"
else
  ln -s $clone_dir/home/bashrc $USER_HOME/.bashrc
  echo "Symlink $USER_HOME/.bashrc created"
fi