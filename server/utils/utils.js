"use strict";

const {Builder, By, Key, until} = require('selenium-webdriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'

let Utils = {
    submit: async function(courseInfo, res, next) {
        let driver = await new Builder().forBrowser('chrome').build();
        console.log("WebDriver successfully built.")

        try {
            await driver.get(registerUrl);

            // login with credentials
            await driver.findElement(By.id('weblogin_netid')).sendKeys(courseInfo.username);
            await driver.findElement(By.id('weblogin_password')).sendKeys(courseInfo.password);
            await driver.findElement(By.xpath('//*[@id="main"]/div[1]/form/ul[2]/li/input')).click();
            res.send("Registration succeesful!");
        } finally {
            // await driver.quit();
        }
    }
}

module.exports = Utils;
