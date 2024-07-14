*** Settings ***
Resource    ./Locators.robot
Resource    ./Keywords.robot
Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser

*** Test Cases ***
Login With Valid Credentials
    Login As Admin    admin    password

Login With Invalid Credentials
    Input Text    ${LOGIN_USERNAME_INPUT}    invalid_user
    Input Text    ${LOGIN_PASSWORD_INPUT}    invalid_pass
    Click Button    ${LOGIN_BUTTON}
    Page Should Contain    Invalid username or password

Add A New User
    Login As Admin    admin    password
    Add New User    newuser    newuser@example.com    password

Delete A User
    Login As Admin    admin    password
    Delete User

Add A New Customer
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890

Delete A Customer
    Login As Admin    admin    password
    Delete Customer

Add A New Order
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890
    Add New Order    newcustomer    100

Delete An Order
    Login As Admin    admin    password
    Delete Order

Validate User Email
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify Data Validation    ${ADD_USER_EMAIL_INPUT}    invalid_email    Invalid email address

Validate User Password Length
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify Data Validation    ${ADD_USER_PASSWORD_INPUT}    short    Password must be at least 6 characters

Validate Customer Phone Number
    Login As Admin    admin    password
    Click Link    ${CUSTOMERS_PAGE_LINK}
    Click Button    ${ADD_CUSTOMER_BUTTON}
    Verify Data Validation    ${CUSTOMER_PHONE_INPUT}    invalid_phone    Invalid phone number

Test Login Performance
    Performance Testing

Test Add User Performance
    Start Timer    start_time
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New User    newuser    newuser@example.com    password
    Stop Timer    end_time
    Log    Time taken for adding a user: ${end_time - start_time} seconds

Test Add Customer Performance
    Start Timer    start_time
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890
    Stop Timer    end_time
    Log    Time taken for adding a customer: ${end_time - start_time} seconds

Verify Dashboard Elements
    Login As Admin    admin    password
    Verify UI Elements    ${DASHBOARD_TITLE}
    Verify UI Elements    ${ADD_USER_LINK}
    Verify UI Elements    ${CUSTOMERS_PAGE_LINK}
    Verify UI Elements    ${ORDERS_PAGE_LINK}

Verify Add User Form Elements
    Login As Admin    admin    password
    Click Link    ${ADD_USER_LINK}
    Verify UI Elements    ${ADD_USER_USERNAME_INPUT}
    Verify UI Elements    ${ADD_USER_EMAIL_INPUT}
    Verify UI Elements    ${ADD_USER_PASSWORD_INPUT}
    Verify UI Elements    ${ADD_USER_BUTTON}

Verify Add Customer Form Elements
    Login As Admin    admin    password
    Click Link    ${CUSTOMERS_PAGE_LINK}
    Click Button    ${ADD_CUSTOMER_BUTTON}
    Verify UI Elements    ${CUSTOMER_NAME_INPUT}
    Verify UI Elements    ${CUSTOMER_EMAIL_INPUT}
    Verify UI Elements    ${CUSTOMER_PHONE_INPUT}
    Verify UI Elements    ${CUSTOMER_SAVE_BUTTON}