#! /bin/bash

set -e

export MVN="$(pwd)/mvnw"

[ -d core/src/main/java ] && $MVN install -DskipTests
rm -rf core/src/main/java
cp ../.github/projects/morphia/core-pom.xml core/pom.xml
rewrite.sh

echo -ne "\033]30;Compiling\007"
$MVN -e -f core/pom.xml test-compile
