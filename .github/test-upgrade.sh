#!/usr/bin/env bash

if [ -z "$SKIP_GIT" ]
then
  git add .
  git reset --hard
  git checkout . #--quiet
fi

echo building project
mvn -q install -DskipTests

echo "*****  updating projecting via openrewrite"
mkdir -p target

MVN_OPTS="-Pmorphia30"

mvn ${MVN_OPTS} -U org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
  -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30 2>&1 \
  -Drewrite.exclusions="**/*.json" \
  2>&1 | tee target/rewrite.out

exit

echo "*****  Rebuilding with the snapshot"

mvn test  ${MVN_OPTS}

git ls-files -m | grep "src/test"

ack --nopager dev.morphia.MorphiaDatastore

