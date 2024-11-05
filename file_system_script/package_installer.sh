#!/usr/bin/env bash

#User-defined list of packages to install
packages=./packages.txt
if [[ ! -f $packages ]];
then
  echo "Packages list $packages not found"
  exit 1
fi

# Defines an array of package named $packages and uses a for loop to iterate through each package. For each package, it checks if it is already installed by searching the local package database (-Qs). If not, it installs the package using pacman -S --noconfirm.
for package in $(cat $packages); 
do
  if pacman -Qs "$package" > /dev/null; # directs the command's output to a null device, which discards any messages or errors  
  then
    echo "$package is already installed"
  else
    echo "installing $package"
    pacman -Syu --noconfirm "$package"
  fi
done


