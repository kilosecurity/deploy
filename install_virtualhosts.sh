#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VHOST_SRC="$SCRIPT_DIR/virtualhosts"
APACHE_SITES="/etc/apache2/sites-available"

if [ ! -d "$VHOST_SRC" ]; then
  echo "!!! Directory virtualhosts non trovata, mona"
  exit 1
fi

for vhost in $VHOST_SRC/*.conf; do
  filename=$(basename "$vhost")

  echo ">>> Installo $filename"

  cp "$vhost" "$APACHE_SITES/$filename"
  a2ensite "$filename"
done

echo ">>> Disabilito default"
a2dissite 000-default.conf || true

echo ">>> Test config Apache"
apachectl configtest

if [ $? -ne 0 ]; then
  echo "!!! Config Apache non funzionante, mona, sistema i vhost"
  exit 1
fi

echo ">>> Reload Apache"
systemctl reload apache2

echo ">>> Virtualhost configurati correttamente"
