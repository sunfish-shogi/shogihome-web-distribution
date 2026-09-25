#!/bin/bash
set -eu
cd "$(dirname "$0")"

source ../config

PROJECT_ROOT=..
SHOGIHOME_ROOT="$PROJECT_ROOT/$SHOGIHOME_DIR_NAME"
OUT_DIR=../dist
DOCS_DIR=../docs

cd "$SHOGIHOME_ROOT"

echo "Build..."
SHOGIHOME_BUILD_PROFILE=../profile.json npm run build -- --outDir "$OUT_DIR"
node ./scripts/report-license.mjs "$DOCS_DIR"
git diff --exit-code

cp ../cloudflare/_headers "$OUT_DIR/_headers"
