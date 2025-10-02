*** Settings ***
Documentation    Teste de login na API
Library          RequestsLibrary
Resource         ../../../resources/services.resource

Suite Setup      Create Session    api    ${API_BASE_URL}

*** Test Cases ***
Test Login Success
    [Documentation]    Testa login com credenciais pré-cadastradas
    [Tags]    login_success
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    Should Not Be Empty    ${token}

Test Login Failure
    [Documentation]    Testa login com credenciais inválidas
    [Tags]    login_failure
    ${resp}=    POST a user login with invalid credentials
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Login Empty Email
    [Documentation]    Testa login com email vazio
    [Tags]    login_validation
    ${resp}=    POST a user login with empty email
    Should Be Equal As Strings    ${resp.json()}[success]    False


Test Login Empty Password
    [Documentation]    Testa login com senha vazia
    [Tags]    login_validation
    ${resp}=    POST a user login with empty password
    Should Be Equal As Strings    ${resp.json()}[success]    False