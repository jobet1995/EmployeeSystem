*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Validate User Email
    Open Browser To Login Page
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify Data Validation    ${ADD_USER_EMAIL_INPUT}    invalid_email    Invalid email address
    [Teardown]    Close Browser

Validate User Password Length
    Open Browser To Login Page
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify Data Validation    ${ADD_USER_PASSWORD_INPUT}    short    Password must be at least 6 characters
    [Teardown]    Close Browser

Validate Customer Phone Number
    Open Browser To Login Page
    Login As Admin    admin    password
    Click Link    ${CUSTOMERS_PAGE_LINK}
    Click Button    ${ADD_CUSTOMER_BUTTON}
    Verify Data Validation    ${CUSTOMER_PHONE_INPUT}    invalid_phone    Invalid phone number
    [Teardown]    Close Browser