#!/bin/bash

# This scripts adds all files to local staging in preparation for committing.

function func_main() {
  git add -A
  echo "All files added."
}

func_main;