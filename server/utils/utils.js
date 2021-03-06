"use strict";

const {Builder,By, Key, until} = require('selenium-webdriver');

const registerUrl = 'https://sdb.admin.uw.edu/students/uwnetid/register.asp'
const loginTestUrl = 'https://my.uw.edu'

// require('geckodriver');

var inProcess = false;

// let browser =''
// if (process.platform === "darwin") { // use chrome for dev 
//     browser = 'chrome';
// } else { // use firefox for prod server
   let browser = 'firefox';
// }

var driver = new Builder().forBrowser(browser).build();
console.log("WebDriver successfully built.")

let Utils = {
    submit: async (courseInfo, res, next) => {
        if (inProcess) {
            await setTimeout(() => Utils.submitWithProcess(courseInfo, new Builder().forBrowser(browser).build(), res, next), 2000)
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
                    var formNotExists = await JSON.parse(JSON.stringify(await driver.findElements(By.xpath('html/body/div[2]/form')))).length
                    if (formNotExists == 0) {
                        res.send("Registration is not yet open."); 
                    } else {
                        let sln1InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[2]/td[1]/input';
                        let sln2InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[3]/td[1]/input';
                        let sln3InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[4]/td[1]/input';
                                            
                        try {
                            if (courseInfo.sln1) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln1);
                            }
                            if (courseInfo.sln2) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln2);
                            }
                            if (courseInfo.sln3) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln3);
                            }
                            await driver.findElement(By.xpath('//*[@id="regform"]/input[7]')).click();
        
                            let result = await driver.findElement(By.xpath('//*[@id="doneDiv"]/b')).getText()
                            if (result.trim() !== 'Schedule updated.') {
                                result = "Schedule not updated: " + await driver.findElement(By.xpath('html/body/div[2]/form/p[2]/table/tbody/tr[2]/td[5]')).getText()
                            } else {
                                result += "\nRegistration Successful!"
                            }

                            /*TODO:
                            - determine sln
                            - find cell, enter sln x n
                            - click submit
                            - get report from <p>
                            - response.send    
                            */
                            res.send(result); 
                        } catch (e) {
                            res.status(500).send("Server Internal Error");
                            inProcess = false;
                            console.log("ERROR", e)
                            if (driver) {
                                let oldDriver = driver
                                driver = new Builder().forBrowser(browser).build();
                                oldDriver.quit();
                            }
                        }
                    }
                    let oldDriver = driver
                    driver = new Builder().forBrowser(browser).build();
                    oldDriver.quit();            
                }
            }
            , 900)
        } catch (e){
            res.status(500).send("Server Internal Error");
            inProcess = false;
            console.log("ERROR", e)
            if (driver) {
                let oldDriver = driver
                driver = new Builder().forBrowser(browser).build();
                oldDriver.quit();
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
                    var formNotExists = await JSON.parse(JSON.stringify(await driver.findElements(By.xpath('html/body/div[2]/form')))).length
                    if (formNotExists == 0) {
                        res.send("Registration is not yet open."); 
                    } else {
                        let sln1InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[2]/td[1]/input';
                        let sln2InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[3]/td[1]/input';
                        let sln3InputXPath = 'html/body/div[2]/form/p[2]/table/tbody/tr[4]/td[1]/input';
                                            
                        try {
                            if (courseInfo.sln1) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln1);
                            }
                            if (courseInfo.sln2) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln2);
                            }
                            if (courseInfo.sln3) {
                                await driver.findElement(By.xpath(sln1InputXPath)).sendKeys(courseInfo.sln3);
                            }
                            await driver.findElement(By.xpath('//*[@id="regform"]/input[7]')).click();
        
                            let result = await driver.findElement(By.xpath('//*[@id="doneDiv"]/b')).getText()
                            if (result.trim() !== 'Schedule updated.') {
                                result = "Schedule not updated: " + await driver.findElement(By.xpath('html/body/div[2]/form/p[2]/table/tbody/tr[2]/td[5]')).getText()
                            } else {
                                result += "\nRegistration Successful!"
                            }

                            /*TODO:
                            - determine sln
                            - find cell, enter sln x n
                            - click submit
                            - get report from <p>
                            - response.send    
                            */
                            res.send(result); 
                        } catch (e) {
                            res.status(500).send("Server Internal Error");
                            console.log("ERROR", e)
                            if (driver) {
                                driver.quit();
                            }
                        }
                    }
                    driver.quit();  
                }
            }, 900)
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
