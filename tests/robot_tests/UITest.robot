*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Verify Dashboard Elements
    Open Browser To Login Page
    Login As Admin    admin    password
    Verify UI Elements    ${DASHBOARD_TITLE}
    Verify UI Elements    ${ADD_USER_LINK}
    Verify UI Elements    ${CUSTOMERS_PAGE_LINK}
    Verify UI Elements    ${ORDERS_PAGE_LINK}
    [Teardown]    Close Browser

Verify Add User Form Elements
    Open Browser To Login Page
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify UI Elements    ${ADD_USER_USERNAME_INPUT}
    Verify UI Elements    ${ADD_USER_EMAIL_INPUT}
    Verify UI Elements    ${ADD_USER_PASSWORD_INPUT}
    Verify UI Elements    ${ADD_USER_BUTTON}
    [Teardown]    Close Browser

Verify Add Customer Form Elements
    Open Browser To Login Page
    Login As Admin    admin    password
    Click Link    ${CUSTOMERS_PAGE_LINK}
    Click Button    ${ADD_CUSTOMER_BUTTON}
    Verify UI Elements    ${CUSTOMER_NAME_INPUT}
    Verify UI Elements    ${CUSTOMER_EMAIL_INPUT}
    Verify UI Elements    ${CUSTOMER_PHONE_INPUT}
    Verify UI Elements    ${CUSTOMER_SAVE_BUTTON}
    [Teardown]    Close Browser