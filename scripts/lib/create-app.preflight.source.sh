#!/bin/bash
#
# Make sure Cordova is installed.
#
# We cannot make full use of Cordova within Docker, it seems.
#
echo "Preflighting cordova."
echo "If this fails visit https://cordova.apache.org/docs/en/10.x/guide/cli/"
cordova -v
docker -v
