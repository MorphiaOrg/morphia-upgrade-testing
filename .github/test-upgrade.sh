#!/usr/bin/env bash

set -e

WORKFLOWS="$( pwd )/.github"
PROJECTS="${WORKFLOWS}/projects"
PATH=${WORKFLOWS}:$PATH

function title() {
    echo -ne "\033]30;$1\007"
}

function checkout() {
  if [ -d git_repo ]
  then
    echo git exists
    cd git_repo ; git checkout . ; cd -
  else
    git clone $( cat git ) git_repo
  fi
}

function upgrade() {
  PROJECT=$1
  PROJECT_ROOT=${WORKFLOWS}/projects/${PROJECT}
  BUILD=${WORKFLOWS}/build.sh
  [ -e ${PROJECT_ROOT}/build.sh ] && BUILD=${PROJECT_ROOT}/build.sh
  echo BUILD=$BUILD

  cd $PROJECT_ROOT

  title "Setting up $PROJECT repository"
  checkout

  title "Initial $PROJECT build"
  $BUILD

  echo -ne "\033]30;Applying recipes\007"
  cd $PROJECT_ROOT/git_repo
  ${WORKFLOWS}/rewrite.sh
  read

  cd $PROJECT_ROOT
  title "final $PROJECT build"
  $BUILD

  title "Done upgrading $PROJECT"
}

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
