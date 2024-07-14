*** Settings ***
Resource    ./Locators.robot
Resource    ./Keywords.robot

*** Test Cases ***
Delete A User
    Open Browser To Login Page
    Login As Admin    admin    password
    Delete User
    [Teardown]    Close Browser