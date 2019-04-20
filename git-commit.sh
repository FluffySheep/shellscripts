#!/bin/bash

# This file commits all files in local staging.

currentBranch=$(git branch | grep \* | cut -d ' ' -f2)
baseBranch=""

function func_main() {
  func_locateBaseBranch
  func_shouldCommitOrAmend
  func_pullBaseBranch
}

# This function checks if a commit should be created or amended.
# You should always amend and refrain from making multiple commits.
function func_shouldCommitOrAmend() {
  echo "Comparing commits between $currentBranch against $baseBranch..."; 
  logDiff=$(git log $baseBranch..$currentBranch)
  if [ -z "$logDiff" ]
  then
    printf "Creating new commit... \n Write a thoughtful commit message:"
	read commitMessage
	git commit -m "$commitMessage"
  else
    # Make an ammend with no change to the commit message
	echo "Ammending existing commit..."
	git commit --amend --no-edit
  fi
}

# Echos the develop branch if it exists. Otherwise will try to echo the master
# branch. If both branches don't exist, will exit the script with an error.
function func_locateBaseBranch() {
  if [[ "$currentBranch" = "develop" || "$currentBranch" = "master" ]]; then
    echo "You can not commit directly to the $currentBranch branch.";
	exit 0;
  fi
  
  # Locate develop branch
  baseBranch=$(git branch | grep develop | cut -d ' ' -f3);
  if [ -z "$baseBranch" ]; then
    baseBranch=$(git branch | grep master | cut -d ' ' -f3);
  fi
  
  # If develop doesn't exist, try locating master
  if [ -z "$baseBranch" ]; then
    echo "Cannot find the develop or master branch";
	exit 0;
  fi
}

function func_pullBaseBranch() {
  git fetch
  git rebase origin/"$baseBranch"
  git log --oneline
}

func_main;