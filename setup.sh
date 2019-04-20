#!/bin/bash

# This script provides all the setup for this project including aliases.
# Much of this script will not work if you aren't in the /scripts/ folder.

# Globals
pwd=$(pwd)

function func_main() {
  func_check_in_scripts_folder;
  func_chmod_scripts;
  func_manual_commands;
}

# Checks to see if you are in the /scripts/ folder. If you are not, then exit
# this script.
function func_check_in_scripts_folder() {
  if [ ${pwd: -8} != "/scripts" ]; then
	printf "\n%s" \
	       "This script must be run from the scripts folder." \
		   "Please navigate to <project>/scripts" "";
	exit 0;
  fi
}

# Makes all scripts writeable.
function func_chmod_scripts() {
  local scriptsFolder="./*";
  for s in $scriptsFolder; do
    if [ ${s: -3} = ".sh" ]; then
      printf "%s\n" "chmod +x $s";
	  chmod +x $s;
	fi
  done
}

# These comamnds must be run manually by the user because they can't be
# automated in shell scripts.
function func_manual_commands() {
  printf "%s\n" \
         "-----------------------------" \
         "Run the command below (use copy and paste):"
  echo
  printf "%s; " \
         "source aliases.sh" \
		 "echo Done.";
  echo
}

func_main;

