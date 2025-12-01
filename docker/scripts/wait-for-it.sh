#!/usr/bin/env bash
# wait-for-it.sh

# Usage: ./wait-for-it.sh host:port [-- command args]

set -e

host_port=(${1//:/ })
HOST=${host_port[0]}
PORT=${host_port[1]}
shift

echo "Waiting for $HOST:$PORT..."

while ! nc -z $HOST $PORT; do
  sleep 1
done

echo "$HOST:$PORT is available"

# Execute command if given
if [ $# -gt 0 ]; then
  exec "$@"
fi
