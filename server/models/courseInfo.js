"use strict";

class CourseInfo {
    constructor(infoJSON) {
        this.username = infoJSON.username;
        this.password = infoJSON.password;
        this.sln = infoJSON.sln;
    }
}

//export the class
module.exports = CourseInfo;