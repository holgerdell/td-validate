#!/bin/bash

VALIDATE=./td-validate

NUM_PASSED=0
NUM_ALL=0

do_test()
{
for file in `find "test/$1" | sort | grep '.gr$' | sed -e 's/\.gr$//g'`;
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
  if [ "0$STATE" -eq "0$2" ]
  then
    tput setaf 2;
    echo "ok  " "$file" "$INFO"
    NUM_PASSED=$[$NUM_PASSED + 1]
  else
    tput setaf 1;
    echo "FAIL" "$file" "$INFO"
  fi
done
}
do_test valid 0
do_test invalid 1

tput sgr0;

echo
echo "$NUM_PASSED of $NUM_ALL tests passed."
echo
