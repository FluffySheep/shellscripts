#!/bin/bash

# This scripts pushes files to local staging in preparation for committing.

function func_main() {
  local currentBranch=$(git branch | grep \* | cut -d ' ' -f2);
  git push -u -f origin $currentBranch
  echo "Done."
}

func_main;