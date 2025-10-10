*** Settings ***
Documentation    Teste de registro de usuário
Resource         ../../resources/base.resource
Resource         ../../resources/services.resource
Library          ../../resources/libs/database.py

Test Setup      Setup Browser
Test Teardown   Take Screenshot

*** Test Cases ***
Test Register Success
    [Documentation]    Registro com dados válidos deve criar usuário
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    
    Go To    ${BASE_URL}/register
    
    Wait For Elements State    css=#name    visible    timeout=${TIMEOUT}
    Fill Text    css=#name    ${user}[name]
    Fill Text    css=#email    ${user}[email]
    Fill Text    css=#password    ${user}[password]
    Fill Text    css=#confirmPassword    ${user}[password]
    Click    css=button >> text=Cadastrar

    Should Show Success Message    Conta criada com sucesso!

Test Register With Invalid Email
    [Documentation]    Registro com email inválido deve falhar
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    
    Go To    ${BASE_URL}/register
    
    Wait For Elements State    css=#name    visible    timeout=${TIMEOUT}
    Fill Text    css=#name    ${user}[name]
    Fill Text    css=#email    invalid@cinema
    Fill Text    css=#password    ${user}[password]
    Fill Text    css=#confirmPassword    ${user}[password]
    Click    css=button >> text=Cadastrar

    Should Show Error Message    Validation failed

Registration Test with Incorrect Password
    [Documentation]    Registro com senhas diferentes deve falhar
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    
    Go To    ${BASE_URL}/register
    
    Wait For Elements State    css=#name    visible    timeout=${TIMEOUT}
    Fill Text    css=#name    ${user}[name]
    Fill Text    css=#email    ${user}[email]
    Fill Text    css=#password    123456
    Fill Text    css=#confirmPassword    654321
    Click    css=button >> text=Cadastrar

    Should Show Error Message    As senhas não coincidem.
