#!/bin/sh
set -eu

dockerd_pid=

shutdown() {
  trap - INT TERM EXIT
  if [ -n "$dockerd_pid" ]; then
    kill "$dockerd_pid" >/dev/null 2>&1 || true
    wait "$dockerd_pid" >/dev/null 2>&1 || true
  fi
}

trap shutdown INT TERM EXIT

/usr/local/bin/dockerd-entrypoint.sh \
  --host=unix:///var/run/docker.sock \
  --storage-driver="${DOCKER_DRIVER:-overlay2}" &
dockerd_pid=$!

attempt=0
until docker info >/dev/null 2>&1; do
  attempt=$((attempt + 1))
  if [ "$attempt" -ge 60 ]; then
    echo "Docker daemon did not become ready" >&2
    exit 1
  fi
  sleep 2
done

supabase start --workdir /workspace

while kill -0 "$dockerd_pid" >/dev/null 2>&1; do
  sleep 5
done

echo "Docker daemon exited unexpectedly" >&2
exit 1
