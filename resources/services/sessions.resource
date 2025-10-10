*** Settings ***
Documentation    Keywords para gerenciamento de sessões na API

Library    RequestsLibrary

Resource    ../base.resource
Resource    ../variables/config.resource

*** Keywords ***
GET all sessions
    ${resp}    GET    url=${API_BASE_URL}/sessions
    ...    expected_status=any

    RETURN    ${resp}

GET sessions by movie
    [Arguments]    ${movie_id}
    ${resp}    GET    url=${API_BASE_URL}/movies/${movie_id}/sessions
    ...    expected_status=any

    RETURN    ${resp}

GET session by id
    [Arguments]    ${session_id}
    ${resp}    GET    url=${API_BASE_URL}/sessions/${session_id}
    ...    expected_status=any

    RETURN    ${resp}