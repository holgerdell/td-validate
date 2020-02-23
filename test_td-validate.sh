#!/usr/bin/env bash

VALIDATE=./td-validate

NUM_PASSED=0
NUM_ALL=0

do_test()
{
for grfile in test/$1/*.gr
do
  file="${grfile%%.gr}"
  NUM_ALL=$[$NUM_ALL + 1]
  if [ -f "$file.td" ]
  then
    $VALIDATE "$grfile" "$file.td" &> /dev/null
    STATE=$?
    INFO="(gr + td)"
  else
    $VALIDATE "$grfile" &> /dev/null
    STATE=$?
    INFO="(gr)"
  fi
  if [ "0$STATE" -eq "0$2" ]
  then
    if tput colors &> /dev/null
    then
      tput setaf 2
    fi
    echo "ok  " "$file" "$INFO"
    NUM_PASSED=$[$NUM_PASSED + 1]
  else
    if tput colors &> /dev/null
    then
      tput setaf 1
    fi
    echo "FAIL" "$file" "$INFO"
  fi
done
}

do_test valid 0
echo
do_test invalid 1
echo
do_test empty 2

if tput colors &> /dev/null
then
  tput sgr0
fi

echo
echo "$NUM_PASSED of $NUM_ALL tests passed."
echo

test $NUM_PASSED = $NUM_ALL
