*** Settings ***

Library     libs/database.py
Library     Browser
Library     RequestsLibrary
Library     Collections
Library     String
Library     JSONLibrary

Resource    variables/config.resource

*** Keywords ***
Setup Browser
    [Documentation]    Configura o browser para testes web
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Set Browser Timeout    ${PAGE_TIMEOUT}

Teardown Browser
    [Documentation]    Fecha o browser após os testes
    Close Browser

API Session
    [Documentation]    Configura sessão para testes de API
    Create Session    api    ${API_BASE_URL}    timeout=${API_TIMEOUT}

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

Do Login
    [Arguments]    ${user}

    Submit Login Form    ${user}
    User Should Be Logged In    ${user}[name]

Get Fixtures
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${TEST_DATA_DIR}${file_name}.json
    ...    encoding=utf-8

    RETURN    ${data}[${scenario}]
