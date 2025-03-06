MORPHIA_CURRENT=2.4.16
MORPHIA_HOME=~/dev/morphia.dev/morphia
MORPHIA_24_HOME=~/dev/morphia.dev/morphia-2.4.x
MORPHIA_JAR=~/.m2/repository/dev/morphia/morphia/morphia-rewrite/3.0.0-SNAPSHOT/morphia-rewrite-3.0.0-SNAPSHOT.jar
MORPHIA_24_JAR=~/.m2/repository/dev/morphia/morphia/morphia-core/$(MORPHIA_CURRENT)-SNAPSHOT/morphia-core-$(MORPHIA_CURRENT)-SNAPSHOT.jar

all: jars
	./reset.sh morphia
	./test-local.sh morphia

jars: $(MORPHIA_JAR) $(MORPHIA_24_JAR)

$(MORPHIA_24_JAR): \
	$( shell find $(MORPHIA_24_HOME)/core -name *.class )
	cd $(MORPHIA_24_HOME)/core && mvn install -DskipTests

$(MORPHIA_JAR): \
	$( shell find $(MORPHIA_HOME)/rewrite -name *.class ) \
	$(MORPHIA_HOME)/rewrite/src/main/resources/META-INF/rewrite/rewrite.yml
	cd $(MORPHIA_HOME)/rewrite && mvn install -DskipTests