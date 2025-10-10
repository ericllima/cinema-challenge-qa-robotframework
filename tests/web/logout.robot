*** Settings ***
Documentation    Teste crítico de logout
Resource         ../../resources/base.resource
Resource         ../../resources/services.resource
Library          ../../resources/libs/database.py

Test Setup      Setup Browser
Test Teardown   Take Screenshot

*** Test Cases ***
Test Logout Success
    [Documentation]    Logout com limpeza de sessão e redirecionamento
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    Insert user into database    ${user}

    Do Login    ${user}
    User Should Be Logged In    ${user}[name]

    Click    css=header .btn-logout

    ${current_url}=    Get Url
    Should Contain    ${current_url}    /login
    Wait For Elements State    css=input[placeholder="Seu e-mail"]    visible    timeout=${TIMEOUT}
