*** Settings ***
Documentation    Teste de registro de usuário na API
Library          RequestsLibrary
Resource         ../../../resources/services.resource

Suite Setup      Create Session    api    ${API_BASE_URL}

*** Test Cases ***
Test Register Success
    [Documentation]    Testa cadastro com dados válidos
    [Tags]    register_success
    ${user}=    Get Fixtures    users    valid_user
    Clean user from database    ${user}[email]
    ${resp}=    POST a user register
    Should Be Equal As Strings    ${resp.json()}[success]    True

Test Register Existing Email
    [Documentation]    Testa cadastro com email já existente
    [Tags]    register_failure
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    ${resp}=    POST a user register with existing email
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Register Empty Name
    [Documentation]    Testa cadastro com nome vazio
    [Tags]    register_validation
    ${resp}=    POST a user register with empty name
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Register Empty Email
    [Documentation]    Testa cadastro com email vazio
    [Tags]    register_validation
    ${resp}=    POST a user register with empty email
    Should Be Equal As Strings    ${resp.json()}[success]    False