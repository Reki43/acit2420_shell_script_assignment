#!/usr/bin/env bash

# ==========================================================================================================================
# Script Name: package_installer.sh
# Description: This script takes the packages located in ./packages.txt and downloads the packages specified in there.
# Author: Henry Wong
# Date: 2024-11-05
# Version: 1.0
# Sources:
#  [1] man pacman | -Q -s --noconfirm | Opens the manual for pacman and find what -Q, -s, and --noconfirm does
# ==========================================================================================================================



# Path to list of packages to install
packages=./packages.txt
if [[ ! -f $packages ]];
then
  echo "Packages list $packages not found"
  exit 1
fi

# Defines an array of package named $packages and uses a for loop to iterate through each package. For each package, it checks if it is already installed by searching the local package database (-Qs). If not, it installs the package using pacman -S --noconfirm [1].
for package in $(cat $packages);
do
# -Q queries the package database. This operation allows you to view installed packages and their files, as well as meta-information about individual packages (dependencies, conflicts, install date, build date, size) [1].
# -s searches each locally-installed package for names or descriptions that match regexp [1].
# --noconfirm bypasses any and all “Are you sure?” messages [1].
  if pacman -Qs "$package" > /dev/null; # directs the command's output to a null device, which discards any messages or errors
  then
    echo "$package is already installed"
  else
    echo "installing $package"
    pacman -Syu --noconfirm "$package"
  fi
done