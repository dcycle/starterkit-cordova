#!/bin/bash
#
# Get configuration.
#

for n in versioned versioned; do
  CANDIDATE="./config/$n"
  if [ -f "$CANDIDATE" ]; then
    source "$CANDIDATE"
  fi
done;
