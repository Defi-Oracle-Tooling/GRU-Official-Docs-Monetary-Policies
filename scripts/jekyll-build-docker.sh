#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
IMAGE="${JEKYLL_DOCKER_IMAGE:-ruby:3.2}"
BUNDLER_VERSION="${BUNDLER_VERSION:-4.0.9}"
BUNDLE_VOLUME="${JEKYLL_BUNDLE_VOLUME:-gru-docs-jekyll-bundle-cache}"
TMP_TAR="$(mktemp)"

cleanup() {
  rm -f "$TMP_TAR"
}
trap cleanup EXIT

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] docker is required for containerized Jekyll builds." >&2
  exit 1
fi

docker volume create "$BUNDLE_VOLUME" >/dev/null

docker run --rm -v "$ROOT_DIR":/src "$IMAGE" bash -lc 'rm -rf /src/_site'

docker run --rm \
  -v "$ROOT_DIR":/src:ro \
  -v "$BUNDLE_VOLUME":/bundle \
  "$IMAGE" \
  bash -lc "
    set -euo pipefail
    mkdir -p /work
    tar -C /src -cf - \
      --exclude _site \
      --exclude .gems \
      --exclude vendor \
      --exclude .jekyll-cache \
      --exclude node_modules \
      . | tar -C /work -xf -
    cd /work
    export GEM_HOME=/tmp/gems
    export BUNDLE_PATH=/bundle
    export BUNDLE_APP_CONFIG=/tmp/.bundle
    export PATH=/tmp/gems/bin:\$PATH
    gem install bundler -v '$BUNDLER_VERSION' --no-document >/dev/null
    bundle _${BUNDLER_VERSION}_ install >/dev/null
    bundle _${BUNDLER_VERSION}_ exec jekyll build --source /work --destination /tmp/_site >&2
    tar -C /tmp -cf - _site
  " > "$TMP_TAR"

mkdir -p "$ROOT_DIR"
tar -C "$ROOT_DIR" -xf "$TMP_TAR"

echo "[DONE] Jekyll site rebuilt in $ROOT_DIR/_site with host-owned files."
