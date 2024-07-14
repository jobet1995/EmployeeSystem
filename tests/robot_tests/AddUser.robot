*** Settings ***
Resource    ./Locators.robot
Resource    ./Keywords.robot

*** Test Cases ***
Add A New User
    Open Browser To Login Page
    Login As Admin    admin    password
    Add New User    newuser    newuser@example.com    password
    [Teardown]    Close Browser