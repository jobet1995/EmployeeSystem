*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Add A New Customer
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890
    [Teardown]    Close Browser

Delete A Customer
    Open Browser To Login Page
    Login As Admin    admin    password
    Delete Customer
    [Teardown]    Close Browser