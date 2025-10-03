*** Settings ***
Documentation    Consumindo a API Cinema App

Library    RequestsLibrary

Resource    base.resource
Resource    variables/config.resource

*** Keywords ***
POST auth request
    [Arguments]    ${endpoint}    ${user_type}=valid_user    ${expected_status}=200    ${empty_field}=${None}    ${extra_fields}=${None}
    ${user}=    Get Fixtures    users    ${user_type}

    ${payload}    Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    IF    $extra_fields is not None
        Set To Dictionary    ${payload}    &{extra_fields}
    END

    IF    $empty_field is not None
        Set To Dictionary    ${payload}    ${empty_field}=
    END

    ${resp}    POST    url=${API_BASE_URL}${endpoint}
    ...    json=${payload}
    ...    expected_status=${expected_status}

    RETURN    ${resp}

POST a user login
    ${user}=    Get Fixtures    users    valid_user

    ${payload}    Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${resp}    POST    url=${API_BASE_URL}/auth/login
    ...    json=${payload}
    ...    expected_status=200

    ${token}    Set Variable   Bearer ${resp.json()}[data][token]

    Set Test Variable     ${token}

POST a user logout
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}    POST    url=${API_BASE_URL}/auth/logout
    ...    headers=${headers}
    ...    expected_status=404

    RETURN    ${resp}

POST a user login with invalid credentials
    ${resp}=    POST auth request    /auth/login    invalid_user    401
    RETURN    ${resp}

POST a user login with empty email
    ${resp}=    POST auth request    /auth/login    valid_user    401    email
    RETURN    ${resp}

POST a user login with empty password
    ${resp}=    POST auth request    /auth/login    valid_user    401    password
    RETURN    ${resp}

POST a user register
    ${user}=    Get Fixtures    users    valid_user
    ${extra_fields}=    Create Dictionary    name=${user}[name]
    ${resp}=    POST auth request    /auth/register    valid_user    201    ${None}    ${extra_fields}
    RETURN    ${resp}

POST a user register with existing email
    ${user}=    Get Fixtures    users    valid_user
    ${extra_fields}=    Create Dictionary    name=${user}[name]
    ${resp}=    POST auth request    /auth/register    valid_user    400    ${None}    ${extra_fields}
    RETURN    ${resp}

POST a user register with empty name
    ${user}=    Get Fixtures    users    valid_user
    ${extra_fields}=    Create Dictionary    name=${user}[name]
    ${resp}=    POST auth request    /auth/register    valid_user    400    name    ${extra_fields}
    RETURN    ${resp}

POST a user register with empty email
    ${user}=    Get Fixtures    users    valid_user
    ${extra_fields}=    Create Dictionary    name=${user}[name]
    ${resp}=    POST auth request    /auth/register    valid_user    400    email    ${extra_fields}
    RETURN    ${resp}

GET user profile
    [Arguments]    ${auth_token}=${token}
    ${headers}=    Create Dictionary    Authorization=${auth_token}
    ${resp}    GET    url=${API_BASE_URL}/auth/me
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${resp}