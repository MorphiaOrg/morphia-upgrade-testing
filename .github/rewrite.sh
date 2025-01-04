#! /bin/bash

echo -ne "\033]30;Applying recipes\007"
$MVN -e -U \
     -DskipMavenParsing=true \
     org.openrewrite.maven:rewrite-maven-plugin:run \
		 -Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:rewrite:3.0.0-SNAPSHOT \
		 -Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30