#! /bin/bash

set -e

cd git_repo

if [ -d core ]
then
  rm -rf $( ls -1 | grep -v core | grep -v mvn)
  git mv -v core/src core/pom.xml .
  rm -r core
  git rm -rf src/main/java
  cp ../core-pom.xml pom.xml
  mvn clean
  find . -name *.json | xargs rm
else
    mvn  test-compile #| grep "\[ERROR\].*\.java.*"
fi

