#!/bin/bash

# Upgrade the OS 
apt update  -y
apt upgrade -y
apt update  -y
apt upgrade -y

# Getting dependencies packages - LAMP Server
PKGLIST="
apache2 ghostscript libapache2-mod-php mysql-server \
php php-bcmath php-curl php-imagick php-intl php-json \
php-mbstring php-mysql php-xml php-zip php-pear php-cgi \
php-common php-gd php mysqlnd php-imap 
"


# Change server name
hostnamectl set-hostname wordpress-web

# Install Dependencies packages
for PKG in ${PKGLIST[@]} ; do apt install $PKG -y ; done

# Install MYSQL package 
apt install -y mysql-client-core-8.0

sudo mkdir -p /var/www
curl https://wordpress.org/latest.tar.gz | sudo tar zx -C /var/www

sudo echo " \
<VirtualHost *:80>
    DocumentRoot /var/www/wordpress
    <Directory /var/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /var/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost> " > /etc/apache2/sites-available/wordpress.conf

# Enable the site with
sudo a2ensite wordpress

# Disable the defaut Ït Works" site
sudo a2dissite 000-default

# Reload to apply all the changes 
sudo service apache2 reload

# Create MySQL database 
sudo mysql -u root -e "CREATE DATABASE wordpress;"
sudo mysql -u root  -e "CREATE USER wordpress@localhost IDENTIFIED BY 'just4now';"
sudo mysql -u root  -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost;"
sudo mysql -u root  -e "FLUSH PRIVILEGES;"

# Enable mysql
sudo service mysql start

# Copy the sample configuration file to wp-config.php
sudo sed '51,58d' /var/www/wordpress/wp-config-sample.php > /var/www/wordpress/wp-config.php
sudo chown nobody:nogroup /var/www/wordpress/wp-config.php
sudo sed -i 's/database_name_here/wordpress/' /var/www/wordpress/wp-config.php
sudo sed -i 's/username_here/wordpress/' /var/www/wordpress/wp-config.php
sudo sed -i 's/password_here/just4now/' /var/www/wordpress/wp-config.php