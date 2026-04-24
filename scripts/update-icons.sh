#!/bin/sh
set -eu

cd /repo

echo "Updating homer-icons (branch: master)..."
git fetch --depth 1 origin master
git reset --hard origin/master

echo "Done."
