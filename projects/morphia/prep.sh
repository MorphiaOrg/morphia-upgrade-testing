#! /bin/bash

set -e

cd git_repo

if [ -d core ]
then
  rm -rf $( ls -1 | grep -v core | grep -v mvn)
  git mv core/src core/pom.xml .
  rm -r core
  git rm -rfq src/main/java
  find . -name *.json | xargs rm
  cp ../core-pom.xml pom.xml
fi

