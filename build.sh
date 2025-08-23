#! /bin/bash

set -e

cd git_repo
mvn -e clean test-compile
