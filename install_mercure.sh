#!/bin/bash

set -e

sudo mkdir -p /opt/mercure

cat <<'EOF' | sudo tee /opt/mercure/Caddyfile > /dev/null
{
    auto_https off
}

:80 {

    encode zstd gzip

    mercure {
        publisher_jwt {env.MERCURE_PUBLISHER_JWT_KEY} HS256
        subscriber_jwt {env.MERCURE_SUBSCRIBER_JWT_KEY} HS256
        allow_credentials
    }
    header {
        Access-Control-Allow-Origin http://nextid.local
        Access-Control-Allow-Credentials true
        Access-Control-Allow-Methods GET, OPTIONS
        Access-Control-Allow-Headers Authorization, Content-Type
        Vary Origin
    }
}
EOF

cat <<'EOF' | sudo tee /opt/mercure/docker-compose.yml > /dev/null
version: "3.8"

services:
  mercure:
    image: dunglas/mercure
    container_name: mercure
    restart: unless-stopped
    ports:
      - "127.0.0.1:3000:80"
    environment:
      MERCURE_PUBLISHER_JWT_KEY: "CHANGE_ME"
      MERCURE_SUBSCRIBER_JWT_KEY: "CHANGE_ME"
EOF

if docker ps -a --format '{{.Names}}' | grep -q '^mercure$'; then
  echo ">>> Mercure già esistente, salto"
  exit 0
fi

echo ">>> Avvio Mercure"

sudo docker run -d \
  --name mercure \
  -p 127.0.0.1:3000:80 \
  -v /opt/mercure/Caddyfile:/etc/caddy/Caddyfile:ro \
  -e MERCURE_PUBLISHER_JWT_KEY="dR5JJsacTfNdEtfwpNpd41rl3mccLhXA3dxdEvjJNT8vI8EVkS3vaxOceWBewmJKyQPWB89DcsYeRCNRaKKKwQ" \
  -e MERCURE_SUBSCRIBER_JWT_KEY="dR5JJsacTfNdEtfwpNpd41rl3mccLhXA3dxdEvjJNT8vI8EVkS3vaxOceWBewmJKyQPWB89DcsYeRCNRaKKKwQ" \
  dunglas/mercure

echo ">>> Mercure avviato correttamente"