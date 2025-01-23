#! /bin/bash

set -e

cd git_repo
mvn -U -e test-compile
