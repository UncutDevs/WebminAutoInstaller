#!/bin/bash
## Script Developed by UncutDevs © 2023

##############################
## Configuration for Webmin ##
##############################
PORT=9090 ## Define port for webmin do not add space
## 0 = http / 1 = https
SSL_ENABLED=0 ## Use https only if you planned to use domain with SSL otherwise go with http to remove https warning
########################################################


## Add Webmint resporitory 
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list


#3 Installing some dependencies and additional stufff

# Update Ubuntu
apt-get update

# Installing some packages
apt-get install -y gnupg2

# Installing zip and rar for software compatibility
apt-get -y install zip unzip
apt-get -y install rar unrar

## Installing wget if missing
apt-get install -y wget nano

# ADding Keys to system
wget --no-check-certificate http://www.webmin.com/jcameron-key.asc && apt-key add jcameron-key.asc

## update System again after adding key
apt-get update

## Installing Webmin
apt-get -y install webmin

## Setting up the values for the webmin in config
sudo sed -i 's/^ssl=.*/ssl='"$SSL_ENABLED"'/g' /etc/webmin/miniserv.conf
sudo sed -i 's/^port=.*/port='"$PORT"'/g' /etc/webmin/miniserv.conf


## Removing defaul miniserv.conf and installing new one
service webmin restart
