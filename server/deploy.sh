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