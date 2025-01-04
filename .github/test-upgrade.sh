#!/usr/bin/env bash

set -e

WORKFLOWS="$( pwd )/.github/"
PROJECTS="${WORKFLOWS}/projects"

function upgrade() {
   gh act --matrix project:$1 | grep -vE "::debug::"
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
