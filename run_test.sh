#!/bin/bash

VALIDATE=./td-validate

NUM_PASSED=0
NUM_ALL=0

for file in `find 'test/valid' | sort | grep '.gr$' | sed -e 's/\.gr$//g'`;
do
  NUM_ALL=$[$NUM_ALL + 1]
  if [ -f "$file.td" ]
  then
    $VALIDATE "$file.gr" "$file.td" &> /dev/null;
    STATE=$?
    INFO="(gr + td)"
  else
    $VALIDATE "$file.gr" &> /dev/null;
    STATE=$?
    INFO="(gr)"
  fi
  if [ "0$STATE" -eq "00" ]
  then
    tput setaf 2;
    echo "ok  " "$file" "$INFO"
    NUM_PASSED=$[$NUM_PASSED + 1]
  else
    tput setaf 1;
    echo "FAIL" "$file" "$INFO"
  fi
done

for file in `find 'test/invalid' | sort | grep '.gr$' | sed -e 's/\.gr$//g'`;
do
  NUM_ALL=$[$NUM_ALL + 1]
  if [ -f "$file.td" ]
  then
    $VALIDATE "$file.gr" "$file.td" &> /dev/null;
    STATE=$?
    INFO="(gr + td)"
  else
    $VALIDATE "$file.gr" &> /dev/null;
    STATE=$?
    INFO="(gr)"
  fi
  if [ "0$STATE" -eq "00" ]
  then
    tput setaf 1;
    echo "FAIL" "$file" "$INFO"
  else
    tput setaf 2;
    echo "ok  " "$file" "$INFO"
    NUM_PASSED=$[$NUM_PASSED + 1]
  fi
done

tput sgr0;

echo
echo "$NUM_PASSED of $NUM_ALL tests passed."
echo
