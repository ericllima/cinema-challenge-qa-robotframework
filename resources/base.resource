*** Settings ***
Library     Browser
Library     RequestsLibrary
Library     Collections
Library     String
Resource    variables/config.robot

*** Keywords ***
Setup Browser
    [Documentation]    Configura o browser para testes web
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Set Browser Timeout    ${DEFAULT_TIMEOUT}

Teardown Browser
    [Documentation]    Fecha o browser após os testes
    Close Browser

Setup API Session
    [Documentation]    Configura sessão para testes de API
    Create Session    cinema_api    ${API_BASE_URL}    timeout=${API_TIMEOUT}

Teardown API Session
    [Documentation]    Remove sessão de API
    Delete All Sessions

Log Test Info
    [Documentation]    Loga informações do teste
    [Arguments]    ${message}
    Log    ${message}    INFO

Wait And Click
    [Documentation]    Aguarda elemento e clica
    [Arguments]    ${locator}
    Wait For Elements State    ${locator}    visible    timeout=${DEFAULT_TIMEOUT}
    Click    ${locator}

Wait And Fill
    [Documentation]    Aguarda elemento e preenche
    [Arguments]    ${locator}    ${text}
    Wait For Elements State    ${locator}    visible    timeout=${DEFAULT_TIMEOUT}
    Fill Text    ${locator}    ${text}