#!/bin/bash

echo
echo "#########################################################"
echo "###  Running Java Formatter (scripts/format-java.sh)  ###"
echo "#########################################################"
echo

files=$(git status -u | grep .java)

for file in $files; do
  if [ ${file: -5} == '.java' ]; then
    echo --$file
	java -jar tools/formatter.jar --replace $file
	echo
  fi
done

git status -u | grep .java
echo "Done."