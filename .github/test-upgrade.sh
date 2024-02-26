#!/usr/bin/env bash

git add .
git reset --hard
git checkout . #--quiet
echo building project
mvn -q install -DskipTests

echo updating projecting via openrewrite

mvn ${MVN_OPTS} -U org.openrewrite.maven:rewrite-maven-plugin:run \
  -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
  -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30 2>&1 \
  -Drewrite.exclusions="**/*.json" \
  2>&1 | tee rewrite.out

mvn test -Dmorphia.version=3.0.0-SNAPSHOT ${MVN_OPTS}

git ls-files -m | grep "src/test"

