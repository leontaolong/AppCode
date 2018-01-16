"use strict";

const express = require('express');
const morgan = require('morgan');

const app = express();
app.use(morgan(process.env.LOGFORMAT || 'dev'));

const port = process.env.PORT || '80';
const host = process.env.HOST || '';

let handlers = require('./handlers/handlers.js');
app.use(handlers());

//error handler
app.use((err, req, res, next) => {
    console.error(err);
    res.status(err.status || 500).send(err.message);
});

app.listen(port, host, () => {
    console.log(`server is listening at http://${host}:${port}...`);
});