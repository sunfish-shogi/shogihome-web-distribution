#!/bin/bash -eu
cd "$(dirname "$0")"

source ../config

PROJECT_ROOT=..
SHOGIHOME_ROOT="$PROJECT_ROOT/$SHOGIHOME_DIR_NAME"
OUT_DIR=../dist

cd "$SHOGIHOME_ROOT"

echo "Build..."
SHOGIHOME_BUILD_PROFILE=../profile.json npm run build -- --outDir $OUT_DIR
node ./scripts/report-license.mjs $OUT_DIR/docs

cp ../cloudflare/_headers $OUT_DIR/_headers
