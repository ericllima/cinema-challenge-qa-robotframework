*** Settings ***
Documentation    Keywords para gerenciamento de theaters na API

Library    RequestsLibrary

Resource    ../base.resource
Resource    ../variables/config.resource

*** Keywords ***
GET all theaters
    ${resp}    GET    url=${API_BASE_URL}/theaters
    ...    expected_status=any

    RETURN    ${resp}

GET theater by id
    [Arguments]    ${theater_id}
    ${resp}    GET    url=${API_BASE_URL}/theaters/${theater_id}
    ...    expected_status=any

    RETURN    ${resp}