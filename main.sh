#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Esegui come root"
    exit 1
fi

set -e
./install_base.sh
./install_mercure.sh
./install_virtualhosts.sh
./setup_project.sh