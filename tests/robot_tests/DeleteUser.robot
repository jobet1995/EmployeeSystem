*** Settings ***
Resource    ./locators.robot
Resource    ./keywords.robot

*** Test Cases ***
Delete A User
    Open Browser To Login Page
    Login As Admin    admin    password
    Delete User
    [Teardown]    Close Browser