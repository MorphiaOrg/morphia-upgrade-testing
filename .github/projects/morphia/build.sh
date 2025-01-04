#! /bin/bash

set -e

cd git_repo
if [ -d core/src/main/java ]
then
  ./mvnw install -DskipTests
  rm -rf core/src/main/java
  cp ../.github/projects/morphia/core-pom.xml core/pom.xml
else
  ./mvnw -e -f core/pom.xml test-compile
fi
