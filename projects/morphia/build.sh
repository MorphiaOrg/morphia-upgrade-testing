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
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk u java $(sdk l java | egrep 'installed|local only' | grep 17 | head -n 1 | cut -d \| -f6)
    sdk u maven 4.0.0-rc-3
    mvn  test-compile #| grep "\[ERROR\].*\.java.*"
fi

