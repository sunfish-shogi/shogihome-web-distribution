#!/bin/bash
set -eu
for CMD_NAME in git npm; do
	echo "Finding '$CMD_NAME'..."
	command -v $CMD_NAME || {
		echo "ERROR: $CMD_NAME not found"
		exit 1
	}
done

echo "Git Version: $(git --version)"
echo "NPM Version: $(npm --version)"
