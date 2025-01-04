#!/usr/bin/env bash

set -e

WORKFLOWS="$( pwd )/.github/"
PROJECTS="${WORKFLOWS}/projects"

function upgrade() {
  if [ -d $1 ]
  then
    pwd
    cd $1 2> /dev/null || echo Can not change to $1
    git checkout -q .
    git pull -q --rebase
    cd - 2> /dev/null
  else
    git clone $( cat $PROJECTS/$1/git ) $1
  fi

  export PATH=$WORKFLOWS:$PATH
  cd $1

  if [ -f $PROJECTS/$1/build.sh ]
  then
    echo -ne "\033]30;Running $1-specific build\007"
    $PROJECTS/$1/build.sh || false
  else
    echo -ne "\033]30;Running standard build\007"
    $WORKFLOWS/build.sh
  fi
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
