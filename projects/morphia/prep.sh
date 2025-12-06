#! /bin/bash

set -e

cd git_repo

if [ -d core ]
then
  rm -rf src
  git mv core/src  .
  for folder in */pom.xml
  do
#    echo Removing $( dirname $folder )
    rm -rf $( dirname $folder )
  done
  rm -rf docs design
  git rm -rfq src/main/java
  find . -name "*.json" | xargs rm
  cp ../core-pom.xml pom.xml
fi

