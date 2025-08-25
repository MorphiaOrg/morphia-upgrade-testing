MORPHIA_CURRENT=2.5.1
MORPHIA_M2=~/.m2/repository/dev/morphia/morphia
MORPHIA_HOME=~/dev/morphia.dev/morphia
MORPHIA_2X_HOME=~/dev/morphia.dev/morphia-2.x
MORPHIA_2X_JAR=$(MORPHIA_M2)/morphia-core/$(MORPHIA_CURRENT)-SNAPSHOT/morphia-core-$(MORPHIA_CURRENT)-SNAPSHOT.jar

MORPHIA_JAR=$(MORPHIA_M2)/morphia-core/3.0.0-SNAPSHOT/morphia-core-3.0.0-SNAPSHOT.jar
REWRITE_JAR=$(MORPHIA_M2)/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar

all: morphia javabot

morphia: jars
	@./bin/reset.sh $@
	@./test-local.sh $@ | tee $@.log

javabot: jars
	@./bin/reset.sh $@
	@./test-local.sh $@ | tee $@.log

jars: $(REWRITE_JAR) $(MORPHIA_2X_JAR) $(MORPHIA_JAR)

$(MORPHIA_2X_JAR): $(shell find $(MORPHIA_2X_HOME)/core -name *.java 2>/dev/null)
	[ -d $(MORPHIA_2X_HOME)/core ] && (cd $(MORPHIA_2X_HOME)/core ; mvn install -DskipTests)

$(MORPHIA_JAR): $(shell find $(MORPHIA_HOME)/core -name *.java 2>/dev/null)
	[ -d $(MORPHIA_HOME)/core ] && (cd $(MORPHIA_HOME)/core/ ; mvn -q install -DskipTests)

$(REWRITE_JAR): $(shell find $(MORPHIA_HOME)/rewrite/src/main 2>/dev/null)
	[ -d $(MORPHIA_HOME)/rewrite ] && (cd $(MORPHIA_HOME)/rewrite/ ; mvn install -DskipTests)

reset:
	@./bin/reset.sh morphia
	@./bin/reset.sh javabot

clean:
	rm -rf projects/*/git_repo

.PHONY: