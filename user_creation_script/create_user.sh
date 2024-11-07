#!/usr/bin/env bash
#create_user.sh [-u uid] [-g gid] [-i info] [-h homedir] [-s shell] username


# Initialize variables
uid=""
gid=""
homedir=""
shell="/bin/bash" # Default shell
username=""


# Function to display usage
usage() {
  echo "Usage: $0 [-u uid] [-g gid] [-h homedir] [-s shell] username"
  echo ""
  echo "Options:"
  echo "    -u: uid             Specify the user ID (UID) | Omit: Defaults to next available UID"
  echo "    -g: gid             Specify the group ID (GID) | Omit: Defaults to a group with the same name as the username"
  echo "    -h: homedir         Specifiy home direcrory | Omit: Defaults to /home/username"
  echo "    -s: shell           Specify shell | Omit: Defaults to /bin/bash"
  echo "    username            Specify username of the new user | Required"
  exit 1
}


# Parse command line options
while getopts ":u:g:h:s:" opt;
do
  case $opt in
    u)
      uid="$OPTARG"
      ;;
    g)
      gid="$OPTARG"
      ;;
    h)
      homedir="$OPTARG"
      ;;
    s)
      shell="$OPTARG"
      ;;
    ?)
      echo "Invalid option: -$OPTARG"
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      usage
      ;;
    esac
  done

# Remove parsed options from positional parameters
shift $(($OPTIND -1))

# Get the username from the only remaning positional parameter that is a non-option arguement
username="$1"

# Check if username is provided. -z checks if the variable is empty
if [ -z "$username" ];
then
  echo "Error: Username is required"
  usage
fi

# Check if uid is empty, if it is, set uid=1000 as default
if [ -z "$uid" ];
then
  uid=1000
  while cut -d : -f3 /etc/passwd | grep -x $uid > /dev/null; # Loop to find an unused uid.
  do
    uid=$((uid+1)) > /dev/null # Increment uid by 1 if unique uid not found
  done
fi


if [ -z "$gid" ];
then
  gid=$(grep users /etc/group | cut -d: -f3)
fi

if [ -z "$homedir" ];
then
  homedir=/home/$1
fi

if [ -z "$shell" ];
then
  echo "Error: shell is required"
else
  shell="/bin/bash"
fi


