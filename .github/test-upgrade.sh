#!/usr/bin/env bash

if [ -d ../morphia/rewrite ]
then
  cd ../morphia/rewrite && mvn install -DskipTests && cd -
fi

git checkout java
#cp ../morphia/rewrite/src/main/resources/META-INF/rewrite/morphia3.yml rewrite.yml


clear

#if [ -z "$SKIP_GIT" ]
#then
#  git add .
#  git reset --hard
#  git checkout . #--quiet
#fi

echo building project
mvn -q install -DskipTests

echo "*****  updating projecting via openrewrite"
mkdir -p target

MVN_OPTS="-Pmorphia30"

mvn rewrite:run

#mvn ${MVN_OPTS} -U org.openrewrite.maven:rewrite-maven-plugin:run \
#  -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30 2>&1 \
#  -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
#  2>&1 | tee target/rewrite.out
#  -Drewrite.exclusions="**/*.json" \


echo "*****  Datastore uses:"
grep -r 'import.*Datastore' java

echo "*****  Updated files:"
git ls-files -m | grep "src/test"

echo "*****  Rebuilding with the snapshot"
mvn test  ${MVN_OPTS}

