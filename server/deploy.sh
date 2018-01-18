#!/bin/bash

npm install

## Chrome webdriver download:

# https://sites.google.com/a/chromium.org/chromedriver/downloads
# cd $HOME/Downloads
# wget http://selenium.googlecode.com/files/chromedriver_mac_13.0.775.0.zip
# unzip chromedriver_mac_13.0.775.zip


## Add driver to PATH 

mkdir -p $HOME/bin
mv chromedriver $HOME/bin
echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bash_profile

# Create SSL cert
openssl req -new -newkey rsa:2048 -nodes -out appcode.leontaolong.com.csr -keyout private.key

# Remove Passphrase from Key
cp private.key private.key.org
openssl rsa -in private.key.org -out private.key

 # Create crt
openssl x509 -req -days 365 -in appcode.leontaolong.com.csr -signkey private.key -out server.crt

# Export ssl path
export KEYPATH=
export CERTPATH=