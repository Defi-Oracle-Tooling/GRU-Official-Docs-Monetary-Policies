#!/usr/bin/env bash
set -euo pipefail
# Helper script to codegen, build, (optionally) deploy the subgraph.
# Usage:
#   SUBGRAPH_NAME=defioracle/gru-subgraph ./scripts/subgraph-build-deploy.sh [deploy]
# Requires GRAPH_ACCESS_TOKEN env var if deploying to hosted/service or graphstudio login already configured.

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[subgraph] Codegen..."
npm run subgraph:codegen

echo "[subgraph] Build..."
npm run subgraph:build

echo "[subgraph] Build artifacts ready under subgraph/build"

if [[ "${1:-}" == "deploy" ]]; then
  if [[ -z "${SUBGRAPH_NAME:-}" ]]; then
    echo "ERROR: SUBGRAPH_NAME env var not set" >&2
    exit 1
  fi
  echo "[subgraph] Deploying to $SUBGRAPH_NAME ..."
  npm run subgraph:deploy || { echo "Deploy failed"; exit 1; }
fi

echo "Done."