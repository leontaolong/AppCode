"use strict";

const {Builder, By, Key, until} = require('selenium-webdriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'

let Utils = {
    submit: async function(courseInfo) {
        let driver = await new Builder().forBrowser('chrome').build();
        console.log("WebDriver successfully built.")

        try {
            await driver.get(rçegisterUrl);

            // login with credentials
            await driver.findElement(By.id('weblogin_netid')).sendKeys(courseInfo.username);
            await driver.findElement(By.id('weblogin_password')).sendKeys(courseInfo.password);
            await driver.findElement(By.xpath('//*[@id="main"]/div[1]/form/ul[2]/li/input')).click();
            // await driver.wait(until.titleIs('webdriver - Google Search'), 1000);
        } finally {
            // await driver.quit();
        }
    }
}

module.exports = Utils;
