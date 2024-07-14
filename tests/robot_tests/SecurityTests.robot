*** Settings ***
Resource    ../resources/security_locators.robot
Resource    ../resources/security_keywords.robot

*** Test Cases ***
SQL Injection Test In User Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject SQL In User Field    ' OR '1'='1
    [Teardown]    Close Browser

SQL Injection Test In Customer Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject SQL In Customer Field    ' OR '1'='1
    [Teardown]    Close Browser

SQL Injection Test In Order Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject SQL In Order Field    ' OR '1'='1
    [Teardown]    Close Browser

XSS Injection Test In User Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject XSS In User Field    <script>alert('XSS')</script>
    [Teardown]    Close Browser

XSS Injection Test In Customer Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject XSS In Customer Field    <script>alert('XSS')</script>
    [Teardown]    Close Browser

XSS Injection Test In Order Field
    Open Browser To Login Page
    Login As Admin    admin    password
    Inject XSS In Order Field    <script>alert('XSS')</script>
    [Teardown]    Close Browser

CSRF Protection Test
    Check CSRF Protection
    [Teardown]    Close Browser

Unauthorized Access Test
    Open Browser    ${URL}/admin
    Page Should Contain    Unauthorized
    [Teardown]    Close Browser

Privilege Escalation Test
    Open Browser    ${URL}/user
    Page Should Not Contain    Admin Panel
    [Teardown]    Close Browser