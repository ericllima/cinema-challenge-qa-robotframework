*** Settings ***
Documentation    Keywords para API de reservations
Library          RequestsLibrary

*** Keywords ***
POST Create Reservation
    [Arguments]    ${session_id}    ${seats}    ${payment_method}=credit_card
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    session=${session_id}    seats=${seats}    paymentMethod=${payment_method}
    ${resp}=    POST    url=${API_BASE_URL}/reservations    headers=${headers}    json=${body}    expected_status=any
    RETURN    ${resp}

GET My Reservations
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    GET    url=${API_BASE_URL}/reservations/me    headers=${headers}    expected_status=any
    RETURN    ${resp}

GET Reservation By ID
    [Arguments]    ${reservation_id}
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    GET    url=${API_BASE_URL}/reservations/${reservation_id}    headers=${headers}    expected_status=any
    RETURN    ${resp}