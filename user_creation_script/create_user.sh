#!/usr/bin/env bash
#create_user.sh [-u uid] [-g gid] [-G group1 group2 group3] [-i info] [-h homedir] [-s shell] username

# Initialize variables
uid=""
gid=""
info=""
homedir=""
shell="/bin/bash" # Default shell
username=""
groups=""

# Function to display usage
usage() {
  echo "Usage: $0 [-u uid] [-g gid] [-G group1 group2 group3] [-i info] [-h homedir] [-s shell] username"
  echo ""
  echo "Options:"
  echo "    -u: uid             Specify the user ID (UID) | Omit: Defaults to next available UID"
  echo "    -g: gid             Specify the group ID (GID) | Omit: Defaults to the same GID as the username's UID"
  echo "    -G: groups          Specify one or more groups | Omit: User will not be added to additional groups"
  echo "    -i: info            Add info about the user like full name"
  echo "    -h: homedir         Specify home directory | Omit: Defaults to /home/username"
  echo "    -s: shell           Specify shell | Omit: Defaults to /bin/bash"
  echo "    username            Specify username of the new user | Required"
  exit 1
}

# Parse command line options
while getopts ":u:g:G:i:h:s:" opt; do
  case $opt in
    u) uid="$OPTARG" ;;
    g) gid="$OPTARG" ;;
    G) groups="$groups $OPTARG" ;; # Add each specified group to the groups list
    i) info="$OPTARG" ;;
    h) homedir="$OPTARG" ;;
    s) shell="$OPTARG" ;;
    ?) echo "Invalid option: -$OPTARG" && usage ;;
    :) echo "Option -$OPTARG requires an argument." && usage ;;
  esac
done

# Remove parsed options from positional parameters
shift $((OPTIND - 1))

# Get the username from the only remaining positional parameter that is a non-option argument
username="$1"

# Check if username is provided
if [ -z "$username" ]; then
  echo "Error: Username is required"
  usage
fi

# Check if uid is empty, if it is, set uid=1000 as default
if [ -z "$uid" ]; then
  uid=1000
  while cut -d : -f3 /etc/passwd | grep -x $uid > /dev/null; do
    uid=$((uid + 1))
  done
fi

# Check if gid is specified, if not, create or assign the group based on the username
if [ -z "$gid" ]; then
  if ! grep -q "^$username:" /etc/group; then
    gid=$uid  # Use the same number as the UID
    echo "$username:x:$gid:" >> /etc/group
  else
    gid=$(grep "^$username:" /etc/group | cut -d: -f3)
  fi
fi

if [ -z "$info" ]; then
  echo "Provide full name of the user:"
  read info
fi

if [ -z "$homedir" ]; then
  homedir=/home/$username
fi

if [ -z "$shell" ]; then
  echo "Error: shell is required"
else
  shell="$shell"
fi

# Add user to /etc/passwd and /etc/shadow
echo "$username:x:$uid:$gid:$info:$homedir:$shell" >> /etc/passwd
echo "$username::::::::" >> /etc/shadow

# Create home directory if it doesn't exist
if mkdir -p "$homedir"; then
  echo "Home directory $homedir created successfully"
else
  echo "Failed to create home directory $homedir."
  exit 1
fi

# Copy skeleton files if /etc/skel exists
if [ -d /etc/skel ];
then
  cp -r /etc/skel/. "$homedir"
else
  echo "/etc/skel directory not found. Skipping skeleton file copy."
fi

# Set permissions and ownership
chmod 755 "$homedir"
# Set permissions and ownership
chown "$username:$username" "$homedir"




# Set user password
passwd "$username"

# Add the user to additional groups if specified
if [ -n "$groups" ]; then
  for group in $groups; do
    # Check if the group already exists in /etc/group
    if ! grep -q "^$group:" /etc/group; then
      echo "Creating group: $group"
      gid=$((gid + 1))  # Increment gid for each new group
      echo "$group:x:$gid:" >> /etc/group
    fi

    # Add user to the group in /etc/group manually
    if grep -q "^$group:" /etc/group; then
      # Get the current line for the group and add the username to the end of the line
      sed -i "/^$group:/ s/$/,$username/" /etc/group
    fi
  done
fi