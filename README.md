# Assignment 2: Shell Scripting

## About This Assignment

**Project 1:** System Setup Scripts - For this assignment, we were tasked to create a script that automates the installation of essential softwares. In addition, the script efficiently creates symbolic links to the configuration files that's already stored in my Git repository. 

**Project 2:** User Creation Script - For the second assignment, we were tasked to create a script that automates creating a user on to yoursystem. It includes setting passwords, assigning initial group memberships, creating home directories, and configuring user shells. 



## Table of Contents

    
1. [Uploading a Custom Image onto DigitalOcean](#uploading-a-custom-image-onto-digitalocean)


# Project 1 - System Setup Scripts

## System Setup Overview


### Objective
Running this script simplifies a new system setup by automating package installation and configuration file management. 

> [!IMPORTANT]
> This script only works for an Arch Linux distribution

### Requirements 
1. Must have root user access or sudo privileges with executable permissions to run the scripts.

2. Clone the entire repository and download all contents to your user home directory. After cloning, the path to the project 1 directory should be: `home/<username>/acit2420_shell_script_assignment/file_system_script.`

### Folder Content

1. **config_script.sh** - Main bash script
2. **config_symlink.sh** - Script to symlink `2420-as2-starting-files/` to user's directory
3. **package_installer.sh** - Script to install the packages in `packages.txt`
4. **packages.txt** - A text file that contains `kakoune` and `tmux`
5. **2420-as2-starting-files** The config directory used for symlink. Includes `/bin` , `/config` , `home` directories. 


### Script Information

1. **config_script.sh** - The main script that sets up and runs both `package_installer.sh` and `config_symlink.sh` script. Includes options to run each script individually.  

2. **config_symlink.sh** - Creates symbolic links from configuration files in `2420-as2-starting-files/` to the user's directories (e.g., ~/bin, ~/.config, and ~/.bashrc).

3. **package_installer.sh** - Installs `kakoune` and `tmux` specified in `packages.txt` using the pacman package manager.
- **kakoune** - A modal code editor inspired by Vim, focusing on efficient multi-cursor workflows. https://wiki.archlinux.org/title/Kakoune
- **Tmux** - A terminal multiplexer that allows multiple terminal sessions within one window, persisting across SSH connections. https://wiki.archlinux.org/title/Tmux


## Instructions

> [!CAUTION]
> Do not change anything 