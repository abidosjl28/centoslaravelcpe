#!/bin/bash
#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"
clear

echo -e "$green          ██╗  ██╗██╗   ██╗██╗     ██╗  ██╗"
echo "          ██║  ██║██║   ██║██║     ██║ ██╔╝"
echo "          ███████║██║   ██║██║     █████╔╝"
echo "          ██╔══██║██║   ██║██║     ██╔═██╗"
echo "          ██║  ██║╚██████╔╝███████╗██║  ██╗"
echo -e "          ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝$nc"
echo ""
echo -e "               $Cyan         Autor:$green @Croelan_Grandez\e[0m$nc\n"
echo -e "               \e[101m[+] Email: croelanjr@gmail.com [+]\e[0m\n"

read -p "Presione Enter para continuar o CTRL+C para Salir"

sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config

yum update -y
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum update -y
yum install -y unzip git curl zip openssl wget firewalld
yum --enablerepo=remi,epel install -y httpd
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
md5sum mysql57-community-release-el7-9.noarch.rpm
rpm -ivh mysql57-community-release-el7-9.noarch.rpm
yum update -y
yum install mysql-server -y

systemctl enable httpd.service
systemctl start httpd.service
systemctl enable mysqld
systemctl start mysqld
systemctl start firewalld
systemctl enable firewalld
systemctl status firewalld

yum --enablerepo=epel,remi-php72 install -y php
yum --enablerepo=remi-php72 list php-*
yum --enablerepo=remi-php72 install -y php-mysql php-xml php-xmlrpc php-soap php-gd php-mbstring php-ctype php-tokenizer
yum --enablerepo=remi-php72 install -y php-zip php-mcrypt php-openssl php-phar php-pdo php-cli 
systemctl restart httpd.service

php -v
httpd -v

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=8000/tcp --permanent
firewall-cmd --reload


curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
chmod +x /usr/bin/composer
# DESCARGA DEL REPOSITORIO DE LARAVEL Y INSTALACION
cd /var/www
git clone https://github.com/laravel/laravel.git
cd /var/www/laravel
composer install
# LOS PERMISOS DE LARAVEL
chown -R apache.apache /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 755 /var/www/laravel/storage
# GENERA LA LLAVE DE LARAVEL
cp .env.example .env
php artisan key:generate
cd /root/CentOSLaravel
cp laravel.conf /etc/httpd/conf.d/
cd /etc/httpd/conf.d
mv welcome.conf welcome.txt
systemctl restart httpd.service
#CREANDO LA CARPETA DEL PROYECTO
cd
wget https://www.rarlab.com/rar/rarlinux-x64-5.6.1.tar.gz
tar -zxvf rarlinux-x64-5.6.1.tar.gz
cd rar*
make && make install

cd /root/CentOSLaravel
unrar x facturaloperues21_v1.1.rar /var/www
#LOS PERMISOS DEL PROYECTO
chown -R apache.apache /var/www/facturaloperues21_v1.1
chmod -R 755 /var/www/facturaloperues21_v1.1
chmod -R 755 /var/www/facturaloperues21_v1.1/storage
chmod -R 777 /var/www/facturaloperues21_v1.1/storage/logs

echo "Nota: Por favor debe cambiar el password del servidor Mysql, el password que aparece es temporal"
grep 'temporary password' /var/log/mysqld.log
echo "Ejecutar el siguiente comando para cambiar el password: mysql_secure_installation"
echo "INSTALACION COMPLETA..."
echo "Por favor reiniciar el servidor, una vez realizado la migracion de la base de datos"
