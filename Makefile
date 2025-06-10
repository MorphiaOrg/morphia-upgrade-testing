MORPHIA_CURRENT=2.5.1
MORPHIA_M2=~/.m2/repository/dev/morphia/morphia
MORPHIA_HOME=~/dev/morphia.dev/morphia
MORPHIA_2X_HOME=~/dev/morphia.dev/morphia-2.x
MORPHIA_2X_JAR=$(MORPHIA_M2)/morphia-core/$(MORPHIA_CURRENT)-SNAPSHOT/morphia-core-$(MORPHIA_CURRENT)-SNAPSHOT.jar

MORPHIA_JAR=$(MORPHIA_M2)/morphia-core/3.0.0-SNAPSHOT/morphia-core-3.0.0-SNAPSHOT.jar
REWRITE_JAR=$(MORPHIA_M2)/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar
REWRITE_FILES=$(shell find $(MORPHIA_HOME)/rewrite -name *.java)
CORE30_FILES=$(shell find $(MORPHIA_HOME)/core -name *.java )

morphia: jars
	./bin/reset.sh $@
	./test-local.sh $@ | tee $@.log

jars: $(REWRITE_JAR) $(MORPHIA_2X_JAR) $(MORPHIA_JAR)

javabot: $(REWRITE_JAR) $(MORPHIA_JAR)
	./bin/reset.sh	 $@
	./test-local.sh $@ | tee $@.log

$(MORPHIA_2X_JAR): $(shell find $(MORPHIA_2X_HOME)/core -name *.java)
	cd $(MORPHIA_2X_HOME)/core ; mvn install -DskipTests

$(MORPHIA_JAR): $(CORE30_FILES)
	cd $(MORPHIA_HOME)/core/ ; mvn -q install -DskipTests

$(REWRITE_JAR): $(MORPHIA_HOME)/rewrite/src/main/resources/META-INF/rewrite/rewrite.yml $(REWRITE_FILES)
	cd $(MORPHIA_HOME)/rewrite/ ; mvn install -DskipTests

clean:
	rm -rf projects/*/git_repo

.PHONY: