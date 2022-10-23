#!/bin/sh
# set -eu

echo "$@"

service cron start

/entrypoint.sh "$@"


# exec /entrypoint.sh "$@"