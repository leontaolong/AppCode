"use strict";

const express = require('express');

//export a function from this module 
module.exports = function() {
    //create a new Mux
    let router = express.Router();

    router.post('/v1/course', (req, res, next) => {
        let courseInfo = req.body;
        console.log(courseInfo);
        // let user = JSON.parse(req.get("Course"));
        // if (user == null) {
        //     res.status(400).send("course info not found")
        // } else {

        // }

        try {
            res.send("request succeesful");
        } catch (err) {
            next(err);
        }
    });

    return router;
};

