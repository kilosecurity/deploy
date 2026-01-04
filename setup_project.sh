#!/bin/bash

set -e

echo ">>> Controllo se la cartella web esiste"
if [ -d "web" ]; then
    echo ">>> Rimuovo la cartella web esistente"
    rm -rf web
fi

echo ">>> Clono il repository da GitHub"
git clone git@github.com:kilosecurity/nextid_web.git web
mv ./web /var/www/web

composer install

php artisan migrate

echo ">>> Progetto configurato correttamente"