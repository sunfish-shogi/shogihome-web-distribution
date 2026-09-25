#!/bin/bash
set -eu
cd "$(dirname "$0")"

source ../config

PROJECT_ROOT=..
SHOGIHOME_ROOT="$PROJECT_ROOT/$SHOGIHOME_DIR_NAME"

cd "$SHOGIHOME_ROOT"

if [ ! -d node_modules ]; then
	echo "Installing node modules..."
	npm ci --ignore-scripts
fi
