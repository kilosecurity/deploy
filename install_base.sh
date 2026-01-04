#!/bin/bash

set -e

echo ">>> Update sistema"
    apt update -y && apt upgrade -y

    echo ">>> Tool base"
    apt install -y \
      ca-certificates \
      curl \
      gnupg \
      software-properties-common \
      unzip \
      build-essential \
      git

echo ">>> Apache"
    apt install -y apache2
    systemctl enable apache2
    systemctl start apache2

echo ">>> MariaDB"
    apt install -y mariadb-server
    systemctl enable mariadb
    systemctl start mariadb


echo ">>> Repo PHP Ondrej"
    add-apt-repository ppa:ondrej/php -y
    apt update -y

    echo ">>> PHP 8.4 + mod_php"
    apt install -y \
      php8.4 \
      libapache2-mod-php8.4 \
      php8.4-cli \
      php8.4-common \
      php8.4-mysql \
      php8.4-curl \
      php8.4-mbstring \
      php8.4-xml \
      php8.4-zip \
      php8.4-gd \
      php8.4-intl

    systemctl restart apache2

     echo ">>> Docker"
    curl -fsSL https://get.docker.com | sh
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu

