#!/usr/bin/env bash

# ==========================================================================================================================
# Script Name: config_script.sh
# Description: This is the main config script that runs both
# Author: Henry Wong
# Date: 2024-11-05
# Version: 1.0
# Sources:
#  [1] https://learning.oreilly.com/videos/bash-shell-scripting/9780137689064/9780137689064-BSS2_04_10_01/ | Working with Options
# ==========================================================================================================================

# Function to display usage information and exit. Source: [1]
usage() {
  echo "Usage: $0 [-h] [-x] [-p] [-s]"
  echo ""
  echo "    -h, --help          Display help"
  echo "    -x  --execute       Execute the main script to install both packages"
  echo "    -p, --packages      Execute package installer"
  echo "    -s, --symlink       Execute symlink creation script"
  exit 1
}

# Default values for variables that control script execution
execute_package_installer=0
execute_symlink=0

# Parse command-line options. Source: [1]
while getopts ":hxps" opt;
do
  case $opt in
    h)  # If -h is provided, display usage information and exit
      usage
      ;;
    x)  # If -x is provided, set both options to run package installer and symlink creation
      execute_package_installer=1
      execute_symlink=1
      ;;
    p)  # If -p is provided, set the option to run the package installer
      execute_package_installer=1
      ;;
    s)  # If -s is provided, set the option to run the symlink creation script
      execute_symlink=1
      ;;
    \?)  # Handle invalid options by displaying a custom error message and usage information
      echo "Invalid option: -$OPTARG"
      usage
      ;;
  esac
done


# Check if no options were provided. Source: [1]
if [[ $OPTIND -eq 1 ]];  #OPTIND tracks the index of the next argument to be processed
then
  echo "NOTE: Make sure to use sudo when executing with -x or -p"
  usage
fi

# Runs both scripts if the -x option is selected. It runs both scripts
if [ "$execute_package_installer" -eq 1 ] && [ "$execute_symlink" -eq 1 ];
then
  echo "Running both scripts..."
  ./package_installer.sh && ./config_symlink.sh
fi

# Run the package installer if the -p option is selected
if [ "$execute_package_installer" -eq 1 ];
then
  if [[ -x ./package_installer.sh ]]; # -x option means if ./package_installer.sh executes, do the following
  then
    echo "Running package installer script..."
    ./package_installer.sh
  else
    echo "package_installer.sh not found or not executable"
    exit 1
  fi
fi

# Run the symlink creation script if the -s option is selected
if [ "$execute_symlink" -eq 1 ];
then
  if [[ -x ./config_symlink.sh ]];
  then
    echo "Running symlink creation script..."
    ./config_symlink.sh
  else
    echo "config_symlink.sh not found or not executable"
    exit 1
  fi
fi