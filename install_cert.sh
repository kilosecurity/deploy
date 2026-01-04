#!/usr/bin/env bash
set -euo pipefail

DOMAIN="nextid.app"
EMAIL="admin@nextid.app"
CREDS="/root/.secrets/certbot/namecheap.ini"

echo ">>> Installo certbot e plugin Namecheap"
apt update
apt install -y certbot python3-certbot-dns-namecheap

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
