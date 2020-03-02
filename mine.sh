#!/bin/bash

#if [ -z "$BASE" ] || [ -z "$BRANCH" ]
#then
#  echo "Set BRANCH and BASE variables"
#  exit -1
#fi
#if [ -z "$1" ] 
#then
#  echo "Must specify a file"
#  exit -1
#fi
#git --no-pager diff $BASE $BRANCH -- $1
git --no-pager show 88ba04129ccecc8acc6fe8 -- $1
