#!/usr/bin/env bash

# ==========================================================================================================================
# Script Name: create_user.sh
# Description: This script creates a new user on your linux system with include various options for setting user ID, group ID,                    additional groups, user info, home directory, and shell.
# Author: Henry Wong
# Date: 2024-11-07
# Version: 1.0
# Sources:
#  [1] https://learning.oreilly.com/videos/bash-shell-scripting/9780137689064/9780137689064-BSS2_04_10_01/ | Working with Options |   Video example script used for reference
#  [2] https://medium.com/@althubianymalek/uid-and-gid-in-executing-a-binary-120e2f67d317 | Difference between UID and EUID
#  [3] https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html | Primary expressions with if statements
#  [4] https://www.geeksforgeeks.org/cut-command-linux-examples/ | cut command in Linux
#  [5] https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux | Using       Grep & Regular Expressions to Search for Text Patterns
#  [6] https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux | The       Basics of Using the Sed Stream Editor to Manipulate Text
#
#
# ==========================================================================================================================

# Checks if the Effective User ID is not 0, indicating not root user. Used to determine if the script has root access rights [2].
if [[ $EUID -ne 0 ]];
then
  echo "Please run this script with root privilege."
  exit 1 # Exit the script with a status of 1 to indicate an error
fi

# Initialize variables for optional parameters
uid=""          # Stores the UID specified with -u option if used
gid=""          # Stores the GID specified with -g option if used
info=""         # Stores additional information about the user (e.g., full name) from -i option
homedir=""      # Stores custom home directory path if specified with -h option
shell="/bin/bash"  # Default shell for the user; will be overridden if -s option is used
username=""     # Variable to store the username specified as a positional argument
groups=""       # Stores additional groups if specified using the -G option

# Function to display script usage instructions for help [1].
usage() {
  echo "Usage: $0 [-u uid] [-g gid] [-G group1 group2 group3] [-i info] [-h homedir] [-s shell] username"
  echo ""
  echo "Options:"
  echo "    -u: uid             Specify the user ID (UID) | Omit: Defaults to next available UID"
  echo "    -g: gid             Specify the group ID (GID) | Omit: Defaults to same GID as username's UID"
  echo "    -G: groups          Specify one or more groups | Omit: User will not be added to additional groups"
  echo "    -i: info            Input user's full name | Not required to "
  echo "    -h: homedir         Specify home directory | Omit: Defaults to /home/username"
  echo "    -s: shell           Specify login shell | Omit: Defaults to /bin/bash"
  echo "    username            Specify username for new user | Required"
  exit 1  # Exit script after displaying usage
}

# Parse command-line options using getopts to read optional flags and arguments [1].
while getopts ":u:g:G:i:h:s:" opt;
do
  case $opt in
    u)
      uid="$OPTARG"  # Set the user ID (UID) if -u is provided
      ;;
    g)
      gid="$OPTARG"  # Set the group ID (GID) if -g is provided
      ;;
    G)
      groups="$groups $OPTARG" # Append each group name provided with -G to the groups variable
      ;;
    i)
      info="$OPTARG"  # Set user information (e.g., full name) if -i is provided
      ;;
    h)
      homedir="$OPTARG"  # Set home directory path if -h is provided
      ;;
    s)
      shell="$OPTARG"  # Set shell path if -s is provided
      ;;
    ?)1
      echo "Invalid option: -$OPTARG"  # Display an error for invalid options
      usage  # Show usage instructions
      ;;
    :)
      echo "Option -$OPTARG requires an argument."  # Display error if option is missing an argument
      usage  # Show usage instructions
      ;;
  esac
done

# Remove parsed options from the positional parameters list. Ex. If 5 options were used. 5-1=4. shifts left 4 positional parameters. Making username the $1 argument [1].
shift $((OPTIND - 1))

# Get the username from the remaining positional parameter [1].
username="$1"  # Store the username provided as the last argument

# Check if the required username parameter is provided [1].
if [ -z "$username" ]; # -z checks if $username variable string is empty [3].
then
  echo "Error: Username is required"  # Display error if username is missing
  usage  # Show usage instructions
fi

# If UID is not provided, find the next available UID starting from 1000 [1]
if [ -z "$uid" ];
then
  uid=1000  # Default starting UID
  # Loop to find the next available UID, starting from 1000 or specified UID
  # Extracts UIDs from /etc/passwd and checks if the current UID ($uid) is already used [4].
  # -x ensures an exact match and the > /dev/null hides grep output [5].
  while cut -d : -f3 /etc/passwd | grep -x $uid > /dev/null;
  do
    uid=$((uid + 1))  # Increment UID until an unused one is found
  done
fi

# If GID is not provided, attempt to create or assign a group based on the username [1].
if [ -z "$gid" ];
then
  # Check if a group exists with the same name as the username [3] [5].
  if ! grep -q "^$username:" /etc/group; # used -q, which doesn't write anything to standard output. Don't have to use > /dev/null
  then
    gid=$uid  # Set GID to UID if no group with username exists
    echo "$username:x:$gid:" >> /etc/group  # Create new group in /etc/group file
  else
    # If group exists, get the existing GID from /etc/group [1].
    gid=$(grep "^$username:" /etc/group | cut -d: -f3)
  fi
fi

# If -i option is typed, prompt the user to enter their user's account's full name [1].
if [ "$info" ];
then
  echo "Provide full name of the user:"  # Prompt for user info of their full name
  read info  # Store user input in the info variable
fi

# If no home directory path is specified, set default to /home/username [1].
if [ -z "$homedir" ];
then
  homedir=/home/$username  # Set default home directory path [1].
fi

# Verify if shell is specified or default to /bin/bash [1].
if [ -z "$shell" ];
then
  echo "Error: shell is required"  # Display error if shell is missing
else
  shell="$shell"  # Assign specified shell to shell variable
fi

# Add user entry to /etc/passwd with provided details [1]
echo "$username:x:$uid:$gid:$info:$homedir:$shell" >> /etc/passwd

# Add user entry to /etc/shadow with placeholder values for password and account info [1]
echo "$username::::::::" >> /etc/shadow

# Create the home directory if it does not already exist
if mkdir -p "$homedir";
then
  echo "Home directory $homedir created successfully"  # Confirm home directory creation
else
  echo "Failed to create home directory $homedir."  # Display error if directory creation fails
  exit 1  # Exit script if unable to create home directory
fi

# Copy default skeleton files from /etc/skel to home directory if /etc/skel exists
if [ -d /etc/skel ];
then
  cp -r /etc/skel/. "$homedir"  # Copy all files from /etc/skel to user’s home directory
else
  echo "/etc/skel directory not found. Skipping skeleton file copy."  # Warn if skeleton directory is missing
fi

# Add the user to additional groups if any are specified in the groups variable
if [ -n "$groups" ];
then
  for group in $groups;
  do
    # Check if the specified group exists in /etc/group
    if ! grep -q "^$group:" /etc/group;
    then
      echo "Creating group: $group"  # Announce new group creation
      gid=$((gid + 1))  # Increment GID for each new group
      echo "$group:x:$gid:" >> /etc/group  # Add new group entry in /etc/group
    fi

    # Append the username to the group's member list in /etc/group
    if grep -q "^$group:" /etc/group;
    then
      sed -i "/^$group:/ s/$/,$username/" /etc/group  # Add user to existing group’s members list
    fi
  done
fi

# Set permissions and ownership of the home directory
chmod 700 "$homedir"  # Restrict access to the home directory (owner only)
chown "$username:$username" "$homedir"  # Set ownership to the new user and their primary group

# Set password for the new user by prompting
passwd "$username"  # Prompt for password for the new user
