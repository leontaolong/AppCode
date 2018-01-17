"use strict";

const {Builder, By, Key, until} = require('selenium-webdriver');

let Utils = {
    submit: async function(courseInfo) {
        let driver = await new Builder().forBrowser('chrome').build();
        console.log("WebDriver successfully built.")
        try {
            await driver.get('http://www.google.com');
            // await driver.findElement(By.name('q')).sendKeys('webdriver', Key.RETURN);
            // await driver.wait(until.titleIs('webdriver - Google Search'), 1000);
        } finally {
            // await driver.quit();
        }
    }
}

module.exports = Utils;
