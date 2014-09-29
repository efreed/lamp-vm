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
  if [[ $buildscript != "#"* ]] && [[ ! -f "/var/$buildscript.done" ]]; then
    # rewrite the script with \r\n converted to \n
    #perl -pi -e 's/\r//' "$buildscript"
    # run the script
    success=FALSE
    source "$buildscript"
    if [[ $success != FALSE ]]; then
      touch "/var/$buildscript.done"
      say "FINISHED $buildscript (and won't run it again)"
    else
      say "FINISHED $buildscript"
    fi
  fi
done
