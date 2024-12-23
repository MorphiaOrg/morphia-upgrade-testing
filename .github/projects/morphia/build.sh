#! /bin/bash

set -e

export MVN="./mvnw"

$MVN install -DskipTests
rewrite.sh
exit

echo Compiling
$MVN -e test-compile 2>&1 | tee target/build.out
