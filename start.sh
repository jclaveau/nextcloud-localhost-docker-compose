#!/bin/bash
export TRUSTED_DOMAINS="$(hostname) $(hostname -I)"

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

docker-compose up
ln -s "$SCRIPT_DIR/data/$USER" "$SCRIPT_DIR/$USER"
mv "$SCRIPT_DIR/data/$USER.bak/*" "$SCRIPT_DIR/data/$USER"
#rm -rf "$SCRIPT_DIR/data/$USER.bak"
docker-compose exec -u 1000 nextcloud php occ files:scan --all
