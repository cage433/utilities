#!/bin/bash

if [ -z "$1" ] 
then
  echo "Must specify a file"
  exit -1
fi

echo "1111111111111111111111111111"
git --no-pager show f4e807ee6461da3 -- $1

echo "2222222222222222222222222222"
git --no-pager show 0d5b2be38ee09c -- $1
