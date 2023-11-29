#!/bin/bash
## Script Developed by UncutDevs © 2023

##############################
## Configuration for Webmin ##
##############################

# Read user input for PORT
read -p "Please specify your port if you plan to use a different port (default: 9090): " PORT

# Use default port if user didn't provide any input
PORT=${PORT:-9090}

# Read user input for SSL_ENABLED
read -p "Do you want to enable SSL? (Y/N, default: N): " SSL_INPUT

# Use default value of 0 (no SSL) if user didn't provide any input
SSL_ENABLED=0

# Check if user input indicates enabling SSL
if [[ $SSL_INPUT == [Yy]* ]]; then
    SSL_ENABLED=1
fi

# Display chosen settings
echo "Using the following settings:"
echo "Port: $PORT"
echo "SSL Enabled: $SSL_ENABLED"

# Check if curl is installed, install if not
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing..."
    apt-get install -y curl
fi

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
