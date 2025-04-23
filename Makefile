MORPHIA_CURRENT=2.5.1
MORPHIA_2X_HOME=~/dev/morphia.dev/morphia-2.x
MORPHIA_2X_JAR=~/.m2/repository/dev/morphia/morphia/morphia-core/$(MORPHIA_CURRENT)-SNAPSHOT/morphia-core-$(MORPHIA_CURRENT)-SNAPSHOT.jar

MORPHIA_HOME=~/dev/morphia.dev/morphia
MORPHIA_JAR=~/.m2/repository/dev/morphia/morphia/morphia-core/3.0.0-SNAPSHOT/morphia-core-3.0.0-SNAPSHOT.jar
REWRITE_JAR=~/.m2/repository/dev/morphia/morphia/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar
REWRITE_FILES=$(shell find $(MORPHIA_HOME)/rewrite -name *.java)
CORE30_FILES=$(shell find $(MORPHIA_HOME)/core -name *.java )

all: jars
	[ -d projects/morphia/git_repo ] && cd projects/morphia/git_repo && git reset --hard || true
	./test-local.sh morphia | tee morphia.out

jars: $(REWRITE_JAR) $(MORPHIA_2X_JAR) $(MORPHIA_JAR)

$(MORPHIA_2X_JAR): $(shell find $(MORPHIA_2X_HOME)/core -name *.java``)
	cd $(MORPHIA_2X_HOME)/core ; mvn install -DskipTests

$(MORPHIA_JAR): $(CORE30_FILES)
	cd $(MORPHIA_HOME)/core/ ; mvn -q install -DskipTests

$(REWRITE_JAR): $(MORPHIA_HOME)/rewrite/src/main/resources/META-INF/rewrite/rewrite.yml $(REWRITE_FILES)
	cd $(MORPHIA_HOME)/rewrite/ ; mvn install -DskipTests

clean:
	rm -rf projects/*/git_repo