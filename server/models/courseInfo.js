"use strict";

class CourseInfo {
    constructor(infoJSON) {
        this.username = infoJSON.username;
        this.password = infoJSON.password;
        this.sln1 = infoJSON.sln1;
        this.sln2 = infoJSON.sln2;
    }
}

//export the class
module.exports = CourseInfo;