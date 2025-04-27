#!/bin/bash

[ -d projects/$1/git_repo ] && cd projects/$1/git_repo && git reset --hard || true
