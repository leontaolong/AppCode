"use strict";

const {Builder,By, Key, until} = require('selenium-webdriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'

require('geckodriver');


var driver = new Builder().forBrowser('firefox').build();
console.log("WebDriver successfully built.")

let Utils = {
    submit: async (courseInfo, res, next) => {

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
                    let oldDriver = driver
                    driver = new Builder().forBrowser('firefox').build();
                    setTimeout( () => {
                        oldDriver.quit();
                    }, 20000)
                }}
            , 200)
        } finally {
            // await driver.quit();
        }
    }
}

module.exports = Utils;
