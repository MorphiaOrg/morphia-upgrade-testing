MORPHIA_CURRENT=2.5.1
MORPHIA_M2=$(HOME)/.m2/repository/dev/morphia/morphia
MORPHIA_HOME?=$(HOME)/dev/morphia.dev/morphia

MORPHIA_JAR=$(MORPHIA_M2)/morphia-core/3.0.0-SNAPSHOT/morphia-core-3.0.0-SNAPSHOT.jar
REWRITE_JAR=$(MORPHIA_M2)/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar

PROJECT_ROOT=projects/$(PROJECT)

$(info HOME=$(HOME))
$(info MORPHIA_HOME=$(MORPHIA_HOME))

all: morphia javabot

morphia:
	@PROJECT=$@ $(MAKE) upgrade

javabot:
	@PROJECT=$@ $(MAKE) upgrade

log:
	@echo "upgrading $(PROJECT)"

upgrade: log checkout jars rewrite build

rewrite:
	@echo "*** Rewriting $(PROJECT)"
	@cd $(PROJECT_ROOT) ; [ -f prep.sh ] && sh prep.sh || true

	@cd $(PROJECT_ROOT)/git_repo ; mvn -e \
		org.openrewrite.maven:rewrite-maven-plugin:run \
		-Drewrite.recipeArtifactCoordinates=dev.morphia.morphia:morphia-rewrite:3.0.0-SNAPSHOT \
		-Drewrite.activeRecipes=dev.morphia.UpgradeToMorphia30,dev.morphia.InternalOnly \
		-Drewrite.recipeChangeLogLevel=DEBUG \
		-Drewrite.exportDatatables=true \
		-Drewrite.exclusions=target/generated-* && \
		mvn spotless:apply || true

build:
	@echo "*** Building $(PROJECT)"
	@cd $(PROJECT_ROOT)/git_repo ; mvn -e clean test-compile

checkout: $(PROJECT_ROOT)/git_repo
	@echo "*** Preparing git_repo for $(PROJECT)"
	@[ -d projects/$(PROJECT)/git_repo ] && cd projects/$(PROJECT)/git_repo && git reset --hard || true

$(PROJECT_ROOT)/git_repo:
	@git clone $(shell cat ${PROJECT_ROOT}/git) $@

jars: $(REWRITE_JAR) $(MORPHIA_JAR)

$(MORPHIA_JAR): $(shell find $(MORPHIA_HOME)/core -name *.java 2>/dev/null)
	[ -d $(MORPHIA_HOME)/core ] && (cd $(MORPHIA_HOME)/core/ ; mvn -q install -DskipTests)

$(REWRITE_JAR): $(shell find $(MORPHIA_HOME)/rewrite/src/main 2>/dev/null)
	[ -d $(MORPHIA_HOME)/rewrite ] && (cd $(MORPHIA_HOME)/rewrite/ ; mvn install -DskipTests)

reset:
	@PROJECT=morphia $(MAKE) -s checkout
	@PROJECT=javabot $(MAKE) -s checkout

clean:
	rm -rf projects/*/git_repo

.PHONY: log rewrite build reset