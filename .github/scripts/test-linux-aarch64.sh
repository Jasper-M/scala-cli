#!/usr/bin/env bash
set -euv

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

cp "$DIR/test-linux-aarch64-from-docker.sh" utils/

docker run $(if test -t 1; then echo "-it"; fi) --rm \
  --volume "$(pwd):/data" \
  -w /data \
  -e "CI=$CI" \
  -e "UPDATE_GH_TOKEN=$UPDATE_GH_TOKEN" \
  -e "SCALA_CLI_IT_FORCED_LAUNCHER_DIRECTORY=$SCALA_CLI_IT_FORCED_LAUNCHER_DIRECTORY" \
  -e "SCALA_CLI_SODIUM_JNI_ALLOW=$SCALA_CLI_SODIUM_JNI_ALLOW" \
  ubuntu:20.04 \
    /data/utils/test-linux-aarch64-from-docker.sh