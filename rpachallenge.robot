#RPA CHALLENGE

*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library  		  Collections
Library           DataDriver  challenge.xlsx  sheet_name=Sheet1

Suite Setup  Start TestCase
Suite Teardown  Finish TestCase
Test Template  Preencher formulario

*** Variables ***
${url}    http://www.rpachallenge.com/
${browser}    chrome

#   Locators

${lFirstname}     xpath://input[@ng-reflect-name = 'labelFirstName']
${lLastname}     xpath://input[@ng-reflect-name = 'labelLastName']
${lEmail}     xpath://input[@ng-reflect-name = 'labelEmail']
${lAddress}     xpath://input[@ng-reflect-name = 'labelAddress']
${lRoleinCompany}     xpath://input[@ng-reflect-name = 'labelRole']
${lCompanyName}     xpath://input[@ng-reflect-name = 'labelCompanyName']
${lPhoneNumber}     xpath://input[@ng-reflect-name = 'labelPhone']
${lSubmit}    xpath://input[@value='Submit']

*** Test Cases ***
Verifica Submissao  ${First Name}  ${Last Name}  ${Email}  ${Address}  ${Role in Company}  ${Company Name}  ${Phone Number}

*** Keywords ***

Start TestCase
    Open Browser  ${url}  ${browser}
    Maximize Browser Window

Finish TestCase
    Close Browser
Preencher formulario
    [Arguments]    ${First Name}  ${Last Name}  ${Email}  ${Address}  ${Role in Company}  ${Company Name}  ${Phone Number}
    Input Text  ${lFirstname}  ${First Name}
    Input Text  ${lLastname}  ${lastname}
    Input Text  ${lEmail}  ${Email}
    Input Text  ${lAddress}  ${Address}
    Input Text  ${lRoleinCompany}  ${Role in Company}
    Input Text  ${lCompanyName}  ${Company Name}
    Input Text  ${lPhoneNumber}  ${Phone Number}
    Capture Page Screenshot
    Click Button  ${lSubmit}