#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

docker-compose down
rm -rf $SCRIPT_DIR/nextcloud
rm -rf $SCRIPT_DIR/data/nextcloud_local.db
mkdir -p $SCRIPT_DIR/data/$USER.bak
mv $SCRIPT_DIR/data/$USER/* "$SCRIPT_DIR/data/$USER.bak"
rm -rf "$SCRIPT_DIR/data/$USER"
