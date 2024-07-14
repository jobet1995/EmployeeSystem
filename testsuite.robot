*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${BROWSER}    Chrome
${URL}        https://c97fe43b-7fe2-418c-a517-a9e146d3bfa7-00-3c1ndth2ixj6f.kirk.replit.dev
${USERNAME}    username
${PASSWORD}    password
${BROWSER}    Chrome

*** Test Cases ***
Login and Verify Dashboard
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id:username    ${USERNAME}
    Input Text    id:password    ${PASSWORD}
    Click Element    id:loginBtn
    Element Should Be Visible    id:dashboard
    Capture Page Screenshot
    Close Browser

Search Product and Add to Cart
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id:searchInput    Product Name
    Click Element    id:searchBtn
    Wait Until Element Is Visible    id:productList
    Click Element    xpath://div[@class='product-item'][1]//button[@class='add-to-cart']
    Wait Until Element Is Visible    id:cartBadge
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Capture Page Screenshot
    Capture Page Screenshot    screenshot.png

Maximize Browser Window
    Maximize Browser Window

Wait Until Element Is Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s

Input Text
    [Arguments]    ${locator}    ${text}
    Input Text    ${locator}    ${text}

Click Element
    [Arguments]    ${locator}
    Click Element    ${locator}

Element Should Be Visible
    [Arguments]    ${locator}
    Element Should Be Visible    ${locator}

Open Browser
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}

Close Browser
    Close Browser