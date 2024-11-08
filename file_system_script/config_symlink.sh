#!/usr/bin/env bash

# ==========================================================================================================================
# Script Name: config_symlink.sh
# Description: This is the symlink config script that will symlink with the repo config that's in the directory.
# Author: Henry Wong
# Date: 2024-11-05
# Version: 1.0
# Sources:
#  [1] man sudo | Look at Environment $SUDO_USER - Opens the manual for sudo options and find what $SUDO_USER does
#  [2] https://www.linode.com/docs/guides/linux-symlinks/ | How to Create Linux Symlinks
#  [3] man ln | -L -s | Opens the manual for symlink options and find what -L and -s does
#  [4] https://medium.com/@althubianymalek/uid-and-gid-in-executing-a-binary-120e2f67d317 | Difference between UID and EUID
#  [5] https://stackoverflow.com/questions/59838/how-do-i-check-if-a-directory-exists-or-not-in-a-bash-shell-script | How do I            check if a directory exists or not in a Bash shell script?
#  [6] https://stackoverflow.com/questions/7358611/get-users-home-directory-when-they-run-a-script-as-root | Get users home               directory when they run a script as root
# ==========================================================================================================================


# Determine the original user's home directory
if [ "$SUDO_USER" ]; # $SUDO_USER: Set to the login name of the user who invoked sudo [1] [6].
then
  # If the script is run with sudo, set USER_HOME to the home directory of the user who invoked sudo [6].
  USER_HOME="/home/$SUDO_USER"
  echo "Script is being run with sudo by user $SUDO_USER"
elif [ "$EUID" -eq 0 ]; #Checks if the Effective User ID is 0, indicating root user. Used to determine if the script has root access rights [4].
then
  # If the script is run by the root user directly
  USER_HOME="/root" # set USER_HOME to root user home
  echo "Script is being run by the root user"
else
  # If not run with sudo, set USER_HOME to the current user's home directory
  USER_HOME=$HOME # set USER_HOME to current user's home
  echo "Script is being run by the current user $USER"
fi



#specifies where the 2420-as2-starting-files is located
clone_dir=$USER_HOME/acit2420_shell_script/file_system_script/2420-as2-starting-files

# Symbolic link for config files

# symlink bin
# Check if $USER_HOME/bin doesn't exist. Create it if necessary [5].
if [ ! -d $USER_HOME/bin ]; then
  mkdir -p $USER_HOME/bin
  echo "/bin directory created"
else
  echo "/bin directory already exists"
fi

# Check if the symlink exists with the option -L [3]. Create it if necessary [2] [5].
if [ -L $USER_HOME/bin/sayhi ]; # dereference TARGETs that are symbolic links [3] [5].
then
  echo "Symlink $USER_HOME/bin/sayhi already exists"
else
  ln -s $clone_dir/bin/sayhi $USER_HOME/bin/sayhi # The option -s make symbolic links instead of hard links [3]
  echo "Symlink $USER_HOME/bin/sayhi created"
fi

# Check if the symlink exists. Create it if necessary [2] [5].
if [ -L $USER_HOME/bin/install-fonts ];
then
  echo "Symlink $USER_HOME/bin/install-fonts already exists"
else
  ln -s $clone_dir/bin/install-fonts $USER_HOME/bin/install-fonts
  echo "Symlink $USER_HOME/bin/install-fonts created"
fi

# symlink config for kak
# Check if $USER_HOME/.config/kak doesn't exist [3]. Create it if necessary [2].
if [ ! -d $USER_HOME/.config/kak ];
then
  mkdir -p $USER_HOME/.config/kak
  echo "/.config/kak directory created"
else
  echo "/.config/kak directory already exists"
fi

# Check if the symlink exists [3]. Create it if necessary [2].
if [ -L $USER_HOME/.config/kak/kakrc ];
then
  echo "Symlink $USER_HOME/.config/kak/kakrc already exists"
else
  ln -s $clone_dir/config/kak/kakrc $USER_HOME/.config/kak/kakrc
  echo "Symlink $USER_HOME/.config/kak/kakrc created"
fi

# symlink config for tmux
# Check if $USER_HOME/.config/tmux doesn't exist [2] [5]. Create it if necessary [3].
if [ ! -d $USER_HOME/.config/tmux ];
then
  mkdir -p $USER_HOME/.config/tmux
  echo "/.config/tmux directory created"
else
  echo "/.config/tmux directory already exists"
fi

# Check if the symlink exists [2]. Create it if necessary [2] [5].
if [ -L $USER_HOME/.config/tmux/tmux.conf ];
then
  echo "Symlink $USER_HOME/.config/tmux/tmux.conf already exists"
else
  ln -s $clone_dir/config/tmux/tmux.conf $USER_HOME/.config/tmux/tmux.conf
  echo "Symlink $USER_HOME/.config/tmux/tmux.conf created"
fi

# symlink home bashrc
# Check if the symlink exists [3]. Create it if necessary [2] [5].
if [ -L $USER_HOME/.bashrc ];
then
  echo "Symlink $USER_HOME/.bashrc already exists"
else
  ln -s $clone_dir/home/bashrc $USER_HOME/.bashrc
  echo "Symlink $USER_HOME/.bashrc created"
fi