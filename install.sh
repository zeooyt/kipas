#!/bin/bash

# Jexactyl Installer Script
echo "Starting Jexactyl Panel Installation..."

# Update the system
sudo apt update && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y curl wget git nginx software-properties-common

# Add Node.js and install
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install MariaDB
sudo apt install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Clone Jexactyl repository
echo "Cloning Jexactyl repository..."
git clone https://github.com/jexactyl/jexactyl.git /var/www/jexactyl

# Install Composer
cd /var/www/jexactyl
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer install --no-dev --optimize-autoloader

# Configure environment
cp .env.example .env
php artisan key:generate

echo "Jexactyl installation completed! Please configure .env and set up your database."

# Restart services
sudo systemctl restart nginx

