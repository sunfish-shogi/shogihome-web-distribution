#!/bin/bash -eu
cd "$(dirname "$0")"

source ../config

PROJECT_ROOT=..
SHOGIHOME_ROOT="$PROJECT_ROOT/$SHOGIHOME_DIR_NAME"

cd "$SHOGIHOME_ROOT"

echo "Build..."
SHOGIHOME_BUILD_PROFILE=../profile.json npm run build -- --outDir ../dist
