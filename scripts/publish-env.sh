#!/bin/bash -eu


source ./scripts/set-version.sh

parse_version $1
#export GPG_TTY=$(tty)

#echo "$GPG_ASC" | base64 -d | gpg --batch --passphrase=$GPG_PASSPHRASE --allow-secret-key-import --import

POM_VERSION=echo '${project.version}\n0\n' | mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate | grep '^VERSION'
echo "Using Project Version:${POM_VERSION}"
mvn clean install -f sunshower-env/parent/pom.xml
mvn clean install deploy  -f sunshower-env/pom.xml
mvn clean install deploy  -f sunshower-env/parent/pom.xml
