*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${LOGIN_USERNAME_INPUT}

Login As Admin
    [Arguments]    ${username}    ${password}
    Input Text    ${LOGIN_USERNAME_INPUT}    ${username}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Dashboard

Inject SQL In User Field
    [Arguments]    ${injection}
    Input Text    ${USER_INPUT_FIELD}    ${injection}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${USER_SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Inject SQL In Customer Field
    [Arguments]    ${injection}
    Input Text    ${CUSTOMER_INPUT_FIELD}    ${injection}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${CUSTOMER_SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Inject SQL In Order Field
    [Arguments]    ${injection}
    Input Text    ${ORDER_INPUT_FIELD}    ${injection}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${ORDER_SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Inject XSS In User Field
    [Arguments]    ${xss}
    Input Text    ${USER_INPUT_FIELD}    ${xss}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Inject XSS In Customer Field
    [Arguments]    ${xss}
    Input Text    ${CUSTOMER_INPUT_FIELD}    ${xss}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Inject XSS In Order Field
    [Arguments]    ${xss}
    Input Text    ${ORDER_INPUT_FIELD}    ${xss}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    ${SUCCESS_MESSAGE}
    Page Should Contain    ${ERROR_MESSAGE}

Check CSRF Protection
    Open Browser    ${URL}/csrf_test
    Page Should Contain    CSRF token mismatch

Check Unauthorized Access
    Open Browser    ${URL}/admin
    Page Should Contain    Unauthorized

Check Privilege Escalation
    Open Browser    ${URL}/user
    Page Should Not Contain    Admin Panel