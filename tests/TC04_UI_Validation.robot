*** Settings ***
Documentation   To validate the Login form
Library     SeleniumLibrary
Test Teardown   Close Browser


*** Variables ***
${Error_Message_Login}      css:.alert-danger
{Chrome_driver}     ${CURDIR}${/}\\Drivers\\chromedriver


*** Test Cases ***
Validate file upload Login
    open the browser with The Oppenheimer Project url
    #Click the file upload button
    Navigate to file path
    #wait until it checks and display success message
    #verify success message is correct

*** Keywords ***
open the browser with The Oppenheimer Project url
    Create Webdriver    Chrome  executable_path={Chrome_driver}
    Go To   http://localhost:8080/

Click the file upload button
       Click Button        //input[@type='file']
Navigate to file path
        Choose File    //input[@type='file']    ${CURDIR}${/}\\Data\\Sample_CSV.csv
















