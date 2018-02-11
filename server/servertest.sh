#!/bin/bash

export PORT=8443
export HTTPPORT=8080
export CERTPATH=/etc/letsencrypt/live/appcode.leontaolong.com/fullchain.pem
export KEYPATH=/etc/letsencrypt/live/appcode.leontaolong.com/privkey.pem

npm start