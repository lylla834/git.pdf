#!/bin/bash
sudo apt update && sudo apt install lamp-server^ -y
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash
sudo apt-get install mariadb-server mariadb-client -y
sudo apt install wordpress -y
sudo chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 wordpress/
sudo service mysql restart
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info
sudo wp cli update
#Désactiver SSL et autoriser connection NAT gateway dans les firewall rules pour que la ligne suivante fonctionne
sudo mariadb --user=azureuser@marialylla --password=Jevis@ambronay --host=marialylla.mariadb.database.azure.com -e "create database wordpresstest;"
cd /
cd usr/share/wordpress
sudo cp -p wp-config-sample.php /home
sudo mv /home/wp-config-sample.php /usr/share/wordpress/wp-config.php
sudo echo "define('FS_METHOD','direct');" >> wp-config.php
sudo wp config set DB_NAME marialylla --allow-root
sudo wp config set DB_USER azureuser@marialylla --allow-root
sudo wp config set DB_HOST marialylla.mariadb.database.azure.com --allow-root
sudo wp config set DB_PASSWORD Jevis@ambronay --allow-root
sudo ln -s /usr/share/wordpress /var/www/html/wordpress