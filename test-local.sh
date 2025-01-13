#!/usr/bin/env bash

set -e

REPO_ROOT="$( pwd )"
PROJECTS="${REPO_ROOT}/projects"
PATH=${REPO_ROOT}:$PATH

function title() {
    echo -ne "\033]30;$1\007"
}

function checkout() {
  if [ -d git_repo ]
  then
    echo git exists
    cd git_repo ; git reset --hard ; cd -
  else
    git clone $( cat git ) git_repo
  fi
}

function upgrade() {
  PROJECT=$1
  PROJECT_ROOT=$( pwd )/projects/${PROJECT}
  BUILD=$( pwd )/build.sh
  [ -e ${PROJECT_ROOT}/build.sh ] && BUILD=${PROJECT_ROOT}/build.sh
  echo BUILD=$BUILD

  cd $PROJECT_ROOT

  title "Setting up $PROJECT repository"
  checkout

  title "Initial $PROJECT build"
  $BUILD

  echo -ne "\033]30;Applying recipes\007"
  cd $PROJECT_ROOT/git_repo
  ${REPO_ROOT}/rewrite.sh

  cd $PROJECT_ROOT
  title "final $PROJECT build"
  $BUILD

  title "Done upgrading $PROJECT"
}

if [ -d ~/dev/morphia.dev ]
then
  cd ~/dev/morphia.dev/morphia/rewrite
  mvn clean install
  cd -
fi

if [ -z "$1" ]
then
  ENTRIES=$( ls -1 $PROJECTS )
  echo found $ENTRIES as probable projects
  for PROJECT in $ENTRIES
  do
    upgrade $PROJECT
  done
else
  upgrade $1
fi
