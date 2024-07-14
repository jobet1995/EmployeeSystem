*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Add A New Order
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New Customer    newcustomer    newcustomer@example.com    1234567890
    Add New Order    newcustomer    100
    [Teardown]    Close Browser

Delete An Order
    Open Browser To Login Page
    Login As Admin    admin    password
    Delete Order
    Delete Customer
    [Teardown]    Close Browser