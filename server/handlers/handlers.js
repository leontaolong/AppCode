"use strict";

const express = require('express');
let CourseInfo = require('../models/courseInfo.js');
let Utils = require('../utils/utils.js');

//export a function from this module 
module.exports = function() {
    //create a new mux
    let router = express.Router();

    router.post('/v1/course', (req, res, next) => {
        let infoJSON = req.body;
        if (!infoJSON.username || !infoJSON.password || !infoJSON.sln) { // handle request error
            res.status(400).send("Bad Request Error: information missing")
        } else {
            var info = new CourseInfo(infoJSON);
            console.log(info);
            try {
                Utils.submit(info);
            } catch (err) {
                next(err);
            }
        }

        try {
            res.send("request succeesful");
        } catch (err) {
            next(err);
        }
    });

    return router;
};

