#! /bin/bash

set -e

export MVN="$(pwd)/mvnw"

[ -d core/src/main/java ] && $MVN install -DskipTests
rm -rf core/src/main/java
cp -v ../.github/projects/morphia/core-pom.xml core/pom.xml
rewrite.sh
read

echo -ne "\033]30;Compiling\007"
$MVN -e -f core/pom.xml dependency:tree 2>&1 | tee -a target/tree.out
$MVN -e -f core/pom.xml test-compile 2>&1 | tee target/build.out
