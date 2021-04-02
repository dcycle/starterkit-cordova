#!/bin/bash
#
# Create mobile app using Cordova.
# See https://cordova.apache.org/docs/en/10.x/guide/cli/.
#
set -e

source ./scripts/lib/config.source.sh
source ./scripts/lib/create-app.preflight.source.sh

URL_TO_WRAP_ESCAPED=$(echo "$URL_TO_WRAP" | sed "s/\//\\\\\//g")
echo $URL_TO_WRAP_ESCAPED
APPFOLDER="my_app"
BASE="$(pwd)"
APPFOLDERFULLPATH="$BASE/$APPFOLDER"
echo "=> Checking if $APPFOLDERFULLPATH exists."
if [ -d "$APPFOLDERFULLPATH" ]; then
  echo " => $APPFOLDERFULLPATH exists."
  echo " => Not doing anything."
  exit 0
fi
echo '=> Creating mobile app using Cordova.'
echo ' => Initializing.'
cordova create "$APPFOLDER" "$REVERSE_DOMAIN" "$HUMAN_READABLE"
echo " => Making sure $URL_TO_WRAP is set as the URL to wrap."
echo " => $URL_TO_WRAP, escaped, is $URL_TO_WRAP_ESCAPED"
sed "s/URL_TO_WRAP/$URL_TO_WRAP_ESCAPED/" "$BASE"/templates/www/js/index.template.js > "$APPFOLDERFULLPATH"/www/js/index.js
echo " => Setting up your app's logo with https://github.com/leonderijke/cordova-assets."
cp "$BASE"/logo/logo.png "$APPFOLDERFULLPATH"/www/img/logo.png
cd "$APPFOLDERFULLPATH"/www/img/ && docker run --rm -v "$(pwd):/app" leonderijke/cordova-assets icon /app/logo.png
echo " => Setting up config.xml from template."
cp "$BASE"/templates/config.template.xml "$APPFOLDERFULLPATH"/config.xml
sed "s/REVERSE_DOMAIN/$REVERSE_DOMAIN/" "$APPFOLDERFULLPATH"/config.xml > "$APPFOLDERFULLPATH"/config2.xml
sed "s/HUMAN_READABLE/$HUMAN_READABLE/" "$APPFOLDERFULLPATH"/config2.xml > "$APPFOLDERFULLPATH"/config.xml
rm "$APPFOLDERFULLPATH"/config2.xml
echo ' => Adding platforms.'
cd "$APPFOLDERFULLPATH" && cordova platform add ios
cd "$APPFOLDERFULLPATH" && cordova platform add android
cd "$APPFOLDERFULLPATH" && cordova platform ls
cd "$APPFOLDERFULLPATH" && cordova plugin add cordova-plugin-inappbrowser
