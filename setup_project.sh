#!/usr/bin/env bash

set -e

echo ">>> Controllo se la cartella web esiste"
if [ -d "/var/www/web/.git" ]; then
    echo ">>> Aggiorno la cartella web esistente"
    git pull origin main
else
    echo ">>> Clono il repository da GitHub"
    git clone git@github.com:kilosecurity/nextid_web.git /var/www/web
fi
cd /var/www/web
composer install --no-dev --optimize-autoloader

php artisan migrate --force

chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo ">>> Progetto configurato correttamente"