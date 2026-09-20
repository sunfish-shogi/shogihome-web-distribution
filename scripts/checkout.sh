#!/bin/bash -eu
cd "$(dirname "$0")"

source ../config

PROJECT_ROOT=..
SHOGIHOME_ROOT="$PROJECT_ROOT/$SHOGIHOME_DIR_NAME"

check_git_state() {
	local REF

	echo "Checking ShogiHome git directory..."

	if [ ! -d "$SHOGIHOME_ROOT/.git" ]; then
		echo "Git directory not found"
		return 1
	fi

	git -C "$SHOGIHOME_ROOT" fetch origin "$SHOGIHOME_TAG"

	if git -C "$SHOGIHOME_ROOT" show-ref --verify --quiet "refs/remotes/origin/$SHOGIHOME_TAG"; then
		REF="refs/remotes/origin/$SHOGIHOME_TAG"
	elif git -C "$SHOGIHOME_ROOT" show-ref --verify --quiet "refs/tags/$SHOGIHOME_TAG"; then
		REF="refs/tags/$SHOGIHOME_TAG"
	else
		echo "WARNING: SHOGIHOME_TAG or tag '$SHOGIHOME_TAG' not found" >&2
		return 1
	fi

	if [ "$(git -C "$SHOGIHOME_ROOT" rev-parse HEAD)" != "$(git -C "$SHOGIHOME_ROOT" rev-parse "$REF")" ]; then
		echo "WARNING: HEAD does not match $REF" >&2
		return 1
	fi

	if [ -n "$(git -C "$SHOGIHOME_ROOT" status --porcelain)" ]; then
		echo "WARNING: working tree is not clean" >&2
		return 1
	fi

	echo "ShogiHome is already cloned."
}

check_git_state || {
	echo "Removing '$SHOGIHOME_ROOT'..."
	rm -rf "$SHOGIHOME_ROOT"
	echo "Cloning '$SHOGIHOME_REPO@$SHOGIHOME_TAG'..."
	git clone --depth 1 --branch "$SHOGIHOME_TAG" "$SHOGIHOME_REPO" "$SHOGIHOME_ROOT"
}
