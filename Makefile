MORPHIA_CURRENT=2.4.16
MORPHIA_24_HOME=~/dev/morphia.dev/morphia-2.4.x
MORPHIA_24_JAR=~/.m2/repository/dev/morphia/morphia/morphia-core/$(MORPHIA_CURRENT)-SNAPSHOT/morphia-core-$(MORPHIA_CURRENT)-SNAPSHOT.jar

MORPHIA_HOME=~/dev/morphia.dev/morphia
MORPHIA_JAR=~/.m2/repository/dev/morphia/morphia/morphia-core/3.0.0-SNAPSHOT/morphia-core-3.0.0-SNAPSHOT.jar
REWRITE_JAR=~/.m2/repository/dev/morphia/morphia/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar
REWRITE_FILES=$(shell find $(MORPHIA_HOME)/rewrite -name *.java)
CORE30_FILES=$(shell find $(MORPHIA_HOME)/core -name *.java )

all: jars
	@./reset.sh morphia || true
	./test-local.sh morphia | tee morphia.out

jars: $(REWRITE_JAR) $(MORPHIA_24_JAR) $(MORPHIA_JAR)

$(MORPHIA_24_JAR): $(shell find $(MORPHIA_24_HOME)/core -name *.java``)
	cd $(MORPHIA_24_HOME)/core ; mvn -q install -DskipTests

$(MORPHIA_JAR): $(CORE30_FILES)
	cd $(MORPHIA_HOME)/core/ ; mvn -q install -DskipTests

$(REWRITE_JAR): $(MORPHIA_HOME)/rewrite/src/main/resources/META-INF/rewrite/rewrite.yml $(REWRITE_FILES)
	cd $(MORPHIA_HOME)/rewrite/ ; mvn -q install -DskipTests