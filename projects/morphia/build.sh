#! /bin/bash

set -e

cd git_repo

if [ -d core ]
then
  rm -rf $( ls -1 | grep -v core | grep -v mvn)
  git mv core/* .
  rmdir core
  git rm -rf src/main/java
  cp ../core-pom.xml pom.xml
  mvn clean
  find . -name *.json | xargs rm
else
  mvn -U -e test-compile #| grep "\[ERROR\].*\.java.*"
fi

