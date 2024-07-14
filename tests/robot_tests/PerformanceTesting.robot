*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Test Login Performance
    Performance Testing
    [Teardown]    Close Browser

Test Add User Performance
    Start Timer    start_time
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New User    newuser    newuser@example.com    password
    Stop Timer    end_time
    Log    Time taken for adding a user: ${end_time - start_time} seconds
    [Teardown]    Close Browser

Test Add Customer Performance
    Start Timer    start_time
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890
    Stop Timer    end_time
    Log    Time taken for adding a customer: ${end_time - start_time} seconds
    [Teardown]    Close Browser