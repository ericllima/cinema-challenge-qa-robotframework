*** Settings ***
Documentation    Teste crítico de login
Resource         ../../resources/base.resource
Resource         ../../resources/services.resource
Library          ../../resources/libs/database.py

Test Setup      Setup Browser
Test Teardown   Take Screenshot

*** Test Cases ***
Test Login Success
    [Documentation]    Login com credenciais válidas - Cenário crítico
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    Insert user into database    ${user}

    Do Login    ${user}
    
    User Should Be Logged In    ${user}[name]
    Should Show Success Message    Login realizado com sucesso!

Test Login With Invalid Email
    [Documentation]    Login com email inválido deve falhar
    
    Go To    ${BASE_URL}/login
    
    Fill Text    css=input[placeholder="Seu e-mail"]    invalid@cinema.com
    Fill Text    css=input[placeholder="Sua senha"]    ${user}[password]
    Click    css=button >> text=Entrar

    Wait For Elements State    css=input[placeholder="Seu e-mail"]    visible    timeout=${TIMEOUT}
    Get Url    should contain    /login

Test Login With Invalid Password
    [Documentation]    Login com senha inválida deve falhar
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    Insert user into database    ${user}
    
    Go To    ${BASE_URL}/login
    Fill Text    css=input[placeholder="Seu e-mail"]    ${user}[email]
    Fill Text    css=input[placeholder="Sua senha"]    wrongpassword
    Click    css=button >> text=Entrar

    Wait For Elements State    css=input[placeholder="Seu e-mail"]    visible    timeout=${TIMEOUT}
    Get Url    should contain    /login

Test Login With Empty Email
    [Documentation]    Login com email vazio deve falhar
    Go To    ${BASE_URL}/login
    
    Fill Text    css=input[placeholder="Sua senha"]    anypassword
    Click    css=button >> text=Entrar

    Wait For Elements State    css=input[placeholder="Seu e-mail"]    visible    timeout=${TIMEOUT}

Test Login With Empty Password
    [Documentation]    Login com senha vazia deve falhar
    ${user}=    Get Fixtures    users    valid_user
    
    Go To    ${BASE_URL}/login
    Fill Text    css=input[placeholder="Seu e-mail"]    ${user}[email]
    Click    css=button >> text=Entrar

    Wait For Elements State    css=input[placeholder="Seu e-mail"]    visible    timeout=${TIMEOUT}