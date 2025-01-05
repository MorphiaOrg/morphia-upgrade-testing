#! /bin/bash

mvn -e -U \
     org.openrewrite.maven:rewrite-maven-plugin:run \
		 -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
		 -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30