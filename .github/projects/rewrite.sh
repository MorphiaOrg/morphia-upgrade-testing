#! /bin/bash

echo Applying recipes
$MVN -e -U org.openrewrite.maven:rewrite-maven-plugin:run \
		 -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
		 -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30 2>&1 | tee target/rewrite.out
