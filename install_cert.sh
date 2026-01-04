#!/usr/bin/env bash
set -euo pipefail

DOMAIN="nextid.app"
EMAIL="admin@nextid.app"
CREDS="/root/.secrets/certbot/namecheap.ini"

echo ">>> Installo certbot e plugin Namecheap"
apt update
sudo snap install certbot --classic
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-namecheap

echo ">>> Richiedo certificato wildcard per *.$DOMAIN"

certbot certonly \
  --dns-namecheap \
  --dns-namecheap-credentials "$CREDS" \
  --dns-namecheap-propagation-seconds 60 \
  -d "$DOMAIN" \
  -d "*.$DOMAIN" \
  --agree-tos \
  -m "$EMAIL" \
  --non-interactive

echo ">>> Certificato wildcard installà, dio boia"
