#!/bin/sh
set -eu

update_on_startup="${UPDATE_ON_STARTUP:-0}"

mkdir -p /www /www/cgi-bin
ln -sf /repo/png /www/png
ln -sf /repo/svg /www/svg
cp /opt/homer-icons/index.html /www/index.html
cp /usr/local/bin/gallery-manifest.cgi /www/cgi-bin/gallery-manifest
chmod +x /www/cgi-bin/gallery-manifest

case "$update_on_startup" in
  1|true|TRUE|yes|YES|on|ON)
    /usr/local/bin/update-icons.sh
    ;;
esac

exec httpd -f -p 8080 -h /www
