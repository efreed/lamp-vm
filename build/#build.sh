#!/usr/bin/env bash


# Enter the relative path to the website's document root
# Example:  pathToWebroot = "/app/www"
# Leave blank if the root of the repo is the root of the website
pathToWebroot=""



################################################################################
# This file does the work of running any *.sh file in the same folder          #
# Unless the file starts with # or ends with "_install.sh" and has already run #
# The files are executed in alphabetical order                                 #
################################################################################

function say {
    printf "\n------------------------------------------------------------------\n"
    printf "\t$1"
    printf "\n------------------------------------------------------------------\n"
}

# specify starting folder
# Note, it's ok if build scripts change the directory
cd /vagrant/build

for buildscript in *.sh
do
  run="yes"
  if [[ $buildscript == "#"* ]]; then
    run="no"
  elif [[ $buildscript == *_install.sh ]]; then
    if [[ -f "/var/ran_$buildscript" ]]; then
      run="no"
    fi
  fi
  if [ $run == "yes" ]; then
    # rewrite the script with \r\n converted to \n
    #perl -pi -e 's/\r//' "$buildscript"
    # run the script
    source "$buildscript"
    if [[ $buildscript == *_install.sh ]]; then
      touch "/var/ran_$buildscript"
      say "FINISHED $buildscript (and won't run it again)"
    else
      say "FINISHED $buildscript"
    fi
  fi
done
