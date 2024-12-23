#! /bin/bash

set -e

if [ -e ~/.bashrc ]
then
  echo bash
  source ~/.bashrc
fi

export MVN=mvn
[ -e mvnw ] && export MVN="./mvnw"

mkdir -p target
rewrite.sh

echo Compiling
$MVN -e test-compile 2>&1 | tee target/build.out
