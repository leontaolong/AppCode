"use strict";

const {Builder, By, Key, until} = require('selenium-webdriver');
require('geckodriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'


let Utils = {
    submit: async (courseInfo, res, next) => {
        let driver = new Builder().forBrowser('firefox').build();
        console.log("WebDriver successfully built.")

        try {
            await driver.get(registerUrl);

            // login with credentials
            await driver.findElement(By.id('weblogin_netid')).sendKeys(courseInfo.username);
            await driver.findElement(By.id('weblogin_password')).sendKeys(courseInfo.password);
            await driver.findElement(By.xpath('//*[@id="main"]/div[1]/form/ul[2]/li/input')).click();
            await setTimeout( async () => {
                let currentSite = await driver.getCurrentUrl();
                if (currentSite != registerUrl) { // login failed
                    res.status(400).send("UW Login Faild: Account info is not correct.");
                } else {
                    /*TODO:
                    - determine sln
                    - find cell, enter sln x n
                    - click submit
                    - get report from <p>
                    - response.send    
                    */
                    res.send("Registration succeesful!");
                }
                await driver.quit();
            }, 200)
        
        } finally {
            // await driver.quit();
        }
    }
}

module.exports = Utils;
