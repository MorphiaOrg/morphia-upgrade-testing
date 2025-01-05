#! /bin/bash

set -e

cd git_repo/core
if [ -d src/main/java ]
then
  rm -rf src/main/java
  cp ../../core-pom.xml pom.xml
fi
  ../mvnw -e test-compile
