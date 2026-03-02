#! /bin/bash

set -e

ROOT_DIR=$(pwd)
cd /tmp/morphia_upgrade/morphia/

if [ -d core ]
then
  rm -rf src
  git mv core/src  .
  for folder in */pom.xml
  do
#    echo Removing $( dirname $folder )
    rm -rf $( dirname $folder )
  done
  rm -rf docs design
  git rm -rfq src/main/java
  find . -name "*.json" | xargs rm
  sed -i"" 's/new Mapper(mapper)/mapper.copy()/g' src/test/java/dev/morphia/test/mapping/TestMapper.java
  cp ${ROOT_DIR}/core-pom.xml pom.xml
  exit
fi

