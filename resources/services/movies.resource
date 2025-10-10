*** Settings ***
Documentation    Keywords para gerenciamento de filmes na API

Library    RequestsLibrary

Resource    ../base.resource
Resource    ../variables/config.resource

*** Keywords ***
GET all movies
    ${resp}    GET    url=${API_BASE_URL}/movies
    ...    expected_status=any

    RETURN    ${resp}

GET movie by id
    [Arguments]    ${movie_id}
    ${resp}    GET    url=${API_BASE_URL}/movies/${movie_id}
    ...    expected_status=any

    RETURN    ${resp}

GET movie sessions
    [Arguments]    ${movie_id}
    ${resp}    GET    url=${API_BASE_URL}/movies/${movie_id}/sessions
    ...    expected_status=any

    RETURN    ${resp}

Reset movie from database
    [Arguments]    ${movie}

    Clean movie from database    ${movie}[title]
    ${movie_id}=    Insert movie into database    ${movie}
    RETURN    ${movie_id}