*** Settings ***
Documentation    Testes de comportamento JWT
Library          RequestsLibrary
Resource         ../../../resources/services.resource

Suite Setup      API Session

*** Test Cases ***
Test Client Side Logout Simulation
    [Documentation]    Simula logout removendo token no cliente
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login

    ${resp}=    GET user profile
    Should Be Equal As Numbers    ${resp.status_code}    200

    ${resp}=    GET user profile    ${EMPTY}
    Should Be Equal As Numbers    ${resp.status_code}    401

Test JWT Stateless Behavior After Logout
    [Documentation]    Demonstra que em JWT o token permanece válido no servidor
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    ${saved_token}=    Set Variable    ${token}
    Set Test Variable    ${saved_token}

    Set Test Variable    ${token}    ${EMPTY}

    ${resp}=    GET user profile    ${saved_token}
    Should Be Equal As Numbers    ${resp.status_code}    200
    Log    Token permanece válido