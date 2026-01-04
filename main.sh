#!/usr/bin/env bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Esegui come root"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/install_base.sh"
"$SCRIPT_DIR/install_mercure.sh"
"$SCRIPT_DIR/install_virtualhosts.sh"
"$SCRIPT_DIR/setup_project.sh"