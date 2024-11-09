# Assignment 2: Shell Scripting

## About This Assignment

**Project 1:** System Setup Scripts - For this assignment, we were tasked to create a script that automates the installation of essential softwares. In addition, the script efficiently creates symbolic links to the configuration files that's already stored in my Git repository. 

**Project 2:** User Creation Script - For the second assignment, we were tasked to create a script that automates creating a user on to yoursystem. It includes setting passwords, assigning initial group memberships, creating home directories, and configuring user shells. 



## Table of Contents
1. [Project 1 - System Setup Scripts](#project-1---system-setup-scripts)
    - [How to Run and Use File System Script](#how-to-run-and-use-file-system-script)
2. [Project 2 - User Creation Script](#project-2---user-creation-script)
    - [How to Run and Use User Creation Script](#how-to-run-and-use-user-creation-script)

3. [References](#references)



---
# Project 1 - System Setup Scripts

## System Setup Overview


### Objective
Simplifies a new system setup by automating package installation and configuration file management. 

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

> [!TIP]
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
> This clones both `file_system_script` and `user_creation_script`

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

## How to Run and Use File System Script

### Usage
```
Usage: sudo ./config_script.sh [-h] [-x] [-p] [-s]
Syntax: sudo ./config_script.sh [OPTION]
 
    -h, --help          Display help
    -x  --execute       Execute the main script to install both packages
    -p, --packages      Execute package installer
    -s, --symlink       Execute symlink creation script
```

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


---
# Project 2 - User Creation Script


## User Creation Overview


### Objective
Simplifies the process of setting up a new user by creating a script that handles shell specification, home directory creation, copying of /etc/skel contents, adding to additional groups, and setting a password using the passwd utility.

### Requirements 
1. Must have root user access or sudo privileges with executable permissions to run the scripts.

### Folder Content
**create_user.sh*** - Main create user script 

### Script Information

**create_user.sh*** - This script simplifies the process of creating a new user on a Linux system. It initializes user-specific options, ensures the script is run with root privileges, and handles command-line options for setting user ID, group ID, additional groups, home directory, and shell. It adds the new user to the system, creates their home directory, copies skeleton files, adds the user to specified groups, sets the correct permissions, and prompts for a password.

## How to Run and Use User Creation Script

> [!IMPORTANT]
> Don't forget to give `./create_user.sh` execute permission by typing chmod +x ./create_user.sh

### Usage

```
Usage: sudo ./create_user.sh [-u uid] [-g gid] [-G group1 -G group2 -G group3 -G ...] [-i] [-h homedir] [-s shell] username
Syntax: create_user [OPTION] [ARGUMENTS]

Options:
    -u: uid             Specify the user ID (UID) | Omit: Defaults to next available UID
    -g: gid             Specify the group ID (GID) | Omit: Defaults to same GID as username's UID
    -G: groups          Specify one or more groups | Omit: User will not be added to additional groups
    -i: info            Prompts user to enter user's full name | Omit: Info about user will be null
    -h: homedir         Specify home directory | Omit: Defaults to /home/username
    -s: shell           Specify login shell | Omit: Defaults to /bin/bash
    username            Specify username for new user | Required
```

### 1. Create a New User with Default Settings
```
sudo ./create_user.sh newuser
```
This command creates a new user named newuser with default settings, including UID, GID, home directory, and login shell.

### 2. Create a New User with a Specified UID and GID
```
sudo ./create_user.sh -u 1001 -g 1001 newuser
```
This command creates a new user named newuser with a specified UID and GID of 1001.

### 3. Create a New User and Add to Additional Groups
```
sudo ./create_user.sh -G group1 -G group2 newuser
```
This command creates a new user named newuser and adds them to group1 and group2.

### 4. Create a New User with a Custom Home Directory and Shell
```
sudo ./create_user.sh -h /custom/home -s /bin/zsh newuser
```
This command creates a new user named newuser with a custom home directory /custom/home and a custom login shell /bin/zsh.

### 5. Create a New User and Prompt for Full Name
```
sudo ./create_user.sh -i newuser
```
This command creates a new user named newuser and prompts the user to enter the new user's full name. 





# References

---

### Bash & Shell Scripting
- [Bash Manual](https://www.gnu.org/software/bash/manual/bash.html) - Official GNU Bash documentation.
- [Advanced Bash Guide](https://tldp.org/LDP/abs/html/) - Comprehensive guide to Bash scripting.
- [Working with Options](https://learning.oreilly.com/videos/bash-shell-scripting/9780137689064/9780137689064-BSS2_04_10_01/) - O'Reilly video covering examples of working with options.
- [Primary Expressions with If Statements](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html) - Basic `if` statement usage in Bash.
- [Cut Command in Linux](https://www.geeksforgeeks.org/cut-command-linux-examples/) - Examples and usage of the `cut` command.
- [Using Grep & Regular Expressions](https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux) - Searching with `grep` and regular expressions.
- [Sed Stream Editor Basics](https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux) - Basic guide to text manipulation with `sed`.

### User and Permissions Management
- [UID and EUID Differences](https://medium.com/@althubianymalek/uid-and-gid-in-executing-a-binary-120e2f67d317) - Explanation of UID and effective UID in executing binaries.
- `man sudo` - Check `$SUDO_USER` environment variable for information on the user who invoked `sudo`.

### File & Directory Operations
- [Checking if a Directory Exists](https://stackoverflow.com/questions/59838/how-do-i-check-if-a-directory-exists-or-not-in-a-bash-shell-script) - Methods to check directory existence in Bash.
- [Getting the User's Home Directory](https://stackoverflow.com/questions/7358611/get-users-home-directory-when-they-run-a-script-as-root) - Retrieving home directory when running as root.
- [Creating Linux Symlinks](https://www.linode.com/docs/guides/linux-symlinks/) - Instructions on creating symbolic links in Linux.
- `man ln` - Use `-L` and `-s` options for creating symlinks.

### Package Management (Arch Linux)
- [Arch Linux Pacman](https://wiki.archlinux.org/title/pacman) - Official documentation for the pacman package manager.
- `man pacman` - Options like `-Q`, `-s`, and `--noconfirm` for package queries and management.
- [Checking for Installed Packages](https://stackoverflow.com/questions/26274415/how-can-i-find-out-whether-a-specific-package-is-already-installed-in-arch-linu) - Methods for checking package installation status in Arch Linux.

### Tools & Utilities
- [Kakoune](https://wiki.archlinux.org/title/Kakoune) - A modal code editor inspired by Vim, focusing on efficient multi-cursor workflows.
- [Tmux](https://wiki.archlinux.org/title/Tmux) - A terminal multiplexer that allows multiple terminal sessions within one window, persisting across SSH connections.
---
