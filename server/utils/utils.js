"use strict";

const {Builder,By, Key, until} = require('selenium-webdriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'

require('geckodriver');


var driver = new Builder().forBrowser('chrome').build();
console.log("WebDriver successfully built.")
var inProcess = false;

let Utils = {
    submit: async (courseInfo, res, next) => {
        if (inProcess) {
            Utils.submitWithProcess(courseInfo, new Builder().forBrowser('chrome').build(), res, next)
        } else {

        inProcess = true;
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
                    res.send("Registration successful!");
                    let oldDriver = driver
                    driver = new Builder().forBrowser('chrome').build();
                    setTimeout( () => {
                        oldDriver.quit();
                    }, 5000)
                }}
            , 200)
        } catch (e){
            res.status(500).send("Server Internal Error");
            console.log("ERROR", e)
            if (driver) {
                let oldDriver = driver
                driver = new Builder().forBrowser('chrome').build();
                inProcess = false;
                setTimeout( () => {
                    oldDriver.quit();
                }, 5000)
            }
            // await driver.quit();
        }
        inProcess = false;
        }
    },
    submitWithProcess: async (courseInfo, driver, res, next) => {
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
                    res.send("Registration successful!");
                    setTimeout( () => {
                        driver.quit();
                    }, 5000)
                }}
            , 200)
        } catch (e){
            res.status(500).send("Server Internal Error");
            console.log("ERROR", e)
            if (driver) {
                driver.quit();
            }
            // await driver.quit();
        }
    }
}

module.exports = Utils;
