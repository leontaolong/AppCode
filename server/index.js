"use strict";

const express = require('express');
const morgan = require('morgan');
const fs = require('fs');
const http = require('http');
const https = require('https');
const bodyParser = require('body-parser');
const forceSsl = require('express-force-ssl');

const app = express();
app.use(morgan(process.env.LOGFORMAT || 'dev'));
app.use(bodyParser.json());
app.use(forceSsl);

const port = process.env.PORT || '8443'; // 443 for deployment
const httpPort = 8080; // 80 for deployment
const host = process.env.HOST || '';

let certPath = process.env.CERTPATH;
let keyPath = process.env.KEYPATH;

var options = {
    key: fs.readFileSync(keyPath),
    cert: fs.readFileSync(certPath),
};

https.createServer(options, app).listen(port, () => {
    console.log(`server running at ${port} ...`)
});

http.createServer(app).listen(httpPort, () => {
    console.log(`server running at ${httpPort} ...`)
});

let handlers = require('./handlers/handlers.js');
app.use(handlers());

//error handler
app.use((err, req, res, next) => {
    console.error(err);
    res.status(err.status || 500).send(err.message);
});


