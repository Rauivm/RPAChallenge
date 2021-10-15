#RPA CHALLENGE

*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library  		  Collections
Library           RPA.HTTP
Library           RPA.Excel.Files
#Library           DataDriver  challenge.xlsx  sheet_name=Sheet1

#Suite Setup  Inicia O Desafio
#Suite Teardown  Coleta Dos Resultados
#Test Template  Preencher E Submeter O Formulario

*** Variables ***
${url}    http://www.rpachallenge.com/
${browser}    chrome

#   Locators
${lStart}    xpath://button[. = 'Start']
${lFirstname}     xpath://input[@ng-reflect-name = 'labelFirstName']
${lLastname}     xpath://input[@ng-reflect-name = 'labelLastName']
${lEmail}     xpath://input[@ng-reflect-name = 'labelEmail']
${lAddress}     xpath://input[@ng-reflect-name = 'labelAddress']
${lRoleinCompany}     xpath://input[@ng-reflect-name = 'labelRole']
${lCompanyName}     xpath://input[@ng-reflect-name = 'labelCompanyName']
${lPhoneNumber}     xpath://input[@ng-reflect-name = 'labelPhone']
${lSubmit}    xpath://input[@value='Submit']

#*** Test Cases ***
#Verifica Submissao  ${First Name}  ${Last Name}  ${Email}  ${Address}  ${Role in Company}  ${Company Name}  ${Phone Number}

*** Keywords ***

Pega A Lista De Pessoas Do Arquivo Excel
    Open Workbook    challenge.xlsx
    ${tabela}=    Read Worksheet As Table    header=True
    CLose Workbook
    [Return]     ${tabela}

*** Keywords ***
Preencher E Submeter O Formulario
    [Arguments]    ${pessoa}
    Input Text  ${lFirstname}  ${pessoa}[First Name]
    Input Text  ${lLastname}  ${pessoa}[Last Name]
    Input Text  ${lEmail}  ${pessoa}[Email]
    Input Text  ${lAddress}  ${pessoa}[Address]
    Input Text  ${lRoleinCompany}  ${pessoa}[Role in Company]
    Input Text  ${lCompanyName}  ${pessoa}[Company Name]
    Input Text  ${lPhoneNumber}  ${pessoa}[Phone Number]
    Click Button  ${lSubmit}

*** Tasks ***    
Inicia O Desafio
    Open Browser  ${url}  ${browser}
    Maximize Browser Window
    Download  http://rpachallenge.com/assets/downloadFiles/challenge.xlsx    overwrite=True
    Wait Until Element Is Visible  ${lStart}
    Click Button  ${lStart}

*** Tasks ***
Preencha O Formulario
    ${pessoas}=    Pega A Lista De Pessoas Do Arquivo Excel
    FOR  ${pessoa}  IN  @{pessoas}
      Preencher E Submeter O Formulario  ${pessoa}
    END
*** Tasks ***
Coleta Dos Resultados
    Capture Element Screenshot    css:div.congratulations
    [Teardown]  Close All Browsers

#Preencher formulario
#    [Arguments]    ${First Name}  ${Last Name}  ${Email}  ${Address}  ${Role in Company}  ${Company Name}  ${Phone Number}
#    Input Text  ${lFirstname}  ${First Name}
#    Input Text  ${lLastname}  ${lastname}
#    Input Text  ${lEmail}  ${Email}
#    Input Text  ${lAddress}  ${Address}
#    Input Text  ${lRoleinCompany}  ${Role in Company}
#    Input Text  ${lCompanyName}  ${Company Name}
#    Input Text  ${lPhoneNumber}  ${Phone Number}
#    Click Button  ${lSubmit}