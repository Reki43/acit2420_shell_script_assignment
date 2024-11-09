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

### Dependencies

> [!IMPORTANT]
> Make sure to do these before proceeding to the next step

This project has a few additional dependencies:

> [TIP]
> If it says "-bash: fzf: command not found" everytime you login in, run the following command in this step.

- **fzf:** A versatile fuzzy finder used in the `bashrc` file found in `/main_configs/home` for our symlink setup. To install `fzf`, run the following code:

```
sudo pacman -Syu fzf
```

- **git:** A version control system to clone this repository and access essential files. To install Git, run the following command:

```
sudo pacman -Syu git
```

- **nvim** Neovim to modify packages.txt. For instance, can edit the packages.txt file to install other packages. Run the following code to install Neovim:

```
sudo pacman -Syu neovim
```

## Clone Instructions

> [!IMPORTANT]
> This includes both `file_system_script` and `user_creation_script`

1. Copy and run the command below to clone this repository:
```
git clone https://github.com/Reki43/acit2420_shell_script_assignment.git
```

> [!CAUTION]
> Do not change anything in the `2420-as2-starting-files/`  directory. May cause errors when running as it'll mess up the symlink and set paths

2. cd into `acit2420_shell_script/` then cd into `file_system_script/`

3. Give script files all executable permission by typing the following:

```
chmod +x config_script.sh config_symlink.sh  package_installer.sh 
```

## How to Run and Use Script

> [!IMPORTANT]
> Make sure to run the main script `./config_script.sh` with sudo

### 1. Display Help
```
./config_script.sh -h
```
This will display the help information.

### 2. Execute Main Script 

```
sudo ./config_script.sh -x
```
This will run the main script to install both packages and create symlinks.

### 3. Execute Package Installer

```
sudo ./config_script.sh -p
```
This will run the package installer script to install all packages listed in `packages.txt` .

### 4. Execute Symlink Script
```
sudo ./config_script.sh -s
```
This will run the symlink creation script to create symbolic links for the configuration files.