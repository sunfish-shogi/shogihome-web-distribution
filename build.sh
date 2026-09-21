#!/bin/bash -eu
cd "$(dirname "$0")"

bash scripts/prerequisites.sh
bash scripts/checkout.sh
bash scripts/install-modules.sh
bash scripts/build.sh
