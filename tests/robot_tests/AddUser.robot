*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Add A New User
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New User    newuser    newuser@example.com    password
    [Teardown]    Close Browser