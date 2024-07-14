*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Login With Valid Credentials
    Open Browser To Login Page
    Login As Admin    admin    password
    [Teardown]    Close Browser

Login With Invalid Credentials
    Open Browser To Login Page
    Input Text    ${LOGIN_USERNAME_INPUT}    invalid_user
    Input Text    ${LOGIN_PASSWORD_INPUT}    invalid_pass
    Click Button    ${LOGIN_BUTTON}
    Page Should Contain    Invalid username or password
    [Teardown]    Close Browser