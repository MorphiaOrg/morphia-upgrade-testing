#!/usr/bin/env bash

PROJECTS="$( pwd )/.github/projects"
if [ -z "$1" ]
then
  echo a project name is needed.  the choices are:
  ls -1 $PROJECTS
  exit
fi

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

export PATH=$PROJECTS:$PATH
cd $1

if [ -f $PROJECTS/$1/build.sh ]
then
  echo Running project-specific build
  $PROJECTS/$1/build.sh
else
  echo Running standard build
  $PROJECTS/build.sh
fi