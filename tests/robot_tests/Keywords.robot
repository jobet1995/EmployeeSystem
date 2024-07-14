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
    Wait Until Page Contains    ${DASHBOARD_TITLE}

Add New User
    [Arguments]    ${username}    ${email}    ${password}
    Click Link    ${ADD_USER_LINK}
    Input Text    ${ADD_USER_USERNAME_INPUT}    ${username}
    Input Text    ${ADD_USER_EMAIL_INPUT}    ${email}
    Input Text    ${ADD_USER_PASSWORD_INPUT}    ${password}
    Click Button    ${ADD_USER_BUTTON}
    Wait Until Page Contains    ${USER_SUCCESS_MESSAGE}

Delete User
    Click Element    ${USER_DELETE_BUTTON}
    Wait Until Page Contains    ${USER_DELETE_SUCCESS}

Add New Customer
    [Arguments]    ${name}    ${email}    ${phone}
    Click Link    ${CUSTOMERS_PAGE_LINK}
    Click Button    ${ADD_CUSTOMER_BUTTON}
    Input Text    ${CUSTOMER_NAME_INPUT}    ${name}
    Input Text    ${CUSTOMER_EMAIL_INPUT}    ${email}
    Input Text    ${CUSTOMER_PHONE_INPUT}    ${phone}
    Click Button    ${CUSTOMER_SAVE_BUTTON}
    Wait Until Page Contains    ${CUSTOMER_SUCCESS_MESSAGE}

Delete Customer
    Click Element    ${CUSTOMER_DELETE_BUTTON}
    Wait Until Page Contains    ${CUSTOMER_DELETE_SUCCESS}

Add New Order
    [Arguments]    ${customer}    ${amount}
    Click Link    ${ORDERS_PAGE_LINK}
    Click Button    ${ADD_ORDER_BUTTON}
    Select From List By Label    ${ORDER_CUSTOMER_SELECT}    ${customer}
    Input Text    ${ORDER_AMOUNT_INPUT}    ${amount}
    Click Button    ${ORDER_SAVE_BUTTON}
    Wait Until Page Contains    ${ORDER_SUCCESS_MESSAGE}

Delete Order
    Click Element    ${ORDER_DELETE_BUTTON}
    Wait Until Page Contains    ${ORDER_DELETE_SUCCESS}

Verify Data Validation
    [Arguments]    ${input_element}    ${invalid_value}    ${error_message}
    Input Text    ${input_element}    ${invalid_value}
    Click Button    ${ADD_USER_BUTTON}
    Wait Until Page Contains    ${error_message}

Check Loading Spinner
    Wait Until Element Is Visible    ${LOADING_SPINNER}
    Wait Until Element Is Not Visible    ${LOADING_SPINNER}

Verify UI Elements
    [Arguments]    ${element_locator}
    Element Should Be Visible    ${element_locator}

Performance Testing
    Start Timer    start_time
    Open Browser To Login Page
    Login As Admin    admin    password
    Stop Timer    end_time
    Log    Time taken for login: ${end_time - start_time} seconds