*** Settings ***
Documentation    Testes de API para criação de reservas
Library          RequestsLibrary
Library          ../../../resources/libs/database.py
Resource         ../../../resources/services.resource
Resource         ../../../resources/services/auth.resource
Resource         ../../../resources/services/reservations.resource

Suite Setup      Setup Test Suite

*** Keywords ***
Setup Test Suite
    API Session
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    Set Suite Variable    ${token}    ${token}
    Setup test movies
    Setup test sessions
    Clean reservations from database
    Set Suite Variable    ${SUITE_USER}    ${user}

*** Test Cases ***
Test Create Reservation Success
    [Documentation]    API cria reserva com sucesso
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][0][_id]
    
    ${seats}=    Create List
    ${seat1}=    Create Dictionary    row=A    number=${1}    type=full
    Append To List    ${seats}    ${seat1}
    
    ${resp}=    POST Create Reservation    ${session_id}    ${seats}    credit_card
    
    Should Be Equal As Numbers    ${resp.status_code}    201
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be True    ${resp.json()}[data][totalPrice] > 0
    Should Be Equal As Strings    ${resp.json()}[data][status]    confirmed
    Should Be Equal As Strings    ${resp.json()}[data][paymentMethod]    credit_card

Test Create Reservation Without Token
    [Documentation]    API retorna erro 401 para usuários não autenticados
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][1][_id]

    ${seats}=    Create List
    ${seat}=    Create Dictionary    row=D    number=${8}    type=full
    Append To List    ${seats}    ${seat}

    ${headers}=    Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    session=${session_id}   seats=${seats}    paymentMethod=credit_card
    ${resp}=    POST    url=${API_BASE_URL}/reservations    headers=${headers}    json=${body}    expected_status=any

    Should Be Equal As Numbers    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Create Reservation With Invalid Session
    [Documentation]    API retorna erro 404 para sessão não encontrada

    ${seats}=    Create List
    ${seat}=    Create Dictionary    row=B    number=${4}    type=full
    Append To List    ${seats}    ${seat}

    ${resp}=    POST Create Reservation    000000000000000000000000    ${seats}    credit_card

    Should Be Equal As Numbers    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Create Reservation Invalid Seats
    [Documentation]    API retorna erro 400 para assentos inválidos
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][0][_id]

    ${seats}=    Create List
    ${seat}=    Create Dictionary    row=V    number=${20}    type=full
    Append To List    ${seats}    ${seat}

    ${resp}=    POST Create Reservation    ${session_id}    ${seats}    credit_card

    Should Be Equal As Numbers    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()}[success]    False

#=====Testes de API para listagem de reservas=====
Test Get My Reservations Success
    [Documentation]    API GET /reservations/me retorna reservas do usuário
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][0][_id]

    ${seats}=    Create List
    ${seat}=    Create Dictionary    row=C    number=${2}    type=full
    Append To List    ${seats}    ${seat}

    ${create_resp}=    POST Create Reservation    ${session_id}    ${seats}    credit_card
    Should Be Equal As Numbers    ${create_resp.status_code}    201

    ${resp}=    GET My Reservations

    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Not Be Empty    ${resp.json()}[data]
    Should Be True    ${resp.json()}[count] >= 1

    ${reservation}=    Set Variable    ${resp.json()}[data][0]
    Should Not Be Empty    ${reservation}[_id]
    Should Not Be Empty    ${reservation}[session]
    Should Not Be Empty    ${reservation}[seats]
    Should Not Be Empty    ${reservation}[status]
    Should Not Be Empty    ${reservation}[paymentMethod]
    Should Be True    ${reservation}[totalPrice] > 0

Test Get My Reservations Without Token
    [Documentation]    API retorna erro 401 para usuários não autenticados
    ${resp}=    GET    url=${API_BASE_URL}/reservations/me    expected_status=any

    Should Be Equal As Numbers    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()}[success]    False

#=====Testes de API para detalhes de reserva=====
Test Get Reservation Details Success
    [Documentation]  API retorna detalhes da reserva
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][0][_id]

    ${seats}=    Create List
    ${seat1}=    Create Dictionary    row=E    number=${10}    type=full
    Append To List    ${seats}    ${seat1}

    ${create_resp}=    POST Create Reservation    ${session_id}    ${seats}    pix
    Should Be Equal As Numbers    ${create_resp.status_code}    201
    ${reservation_id}=    Set Variable    ${create_resp.json()}[data][_id]

    ${resp}=    GET Reservation By ID    ${reservation_id}

    ${reservation}=    Set Variable    ${resp.json()}[data]
    Should Be Equal As Strings    ${reservation}[_id]    ${reservation_id}
    Should Be Equal As Strings    ${reservation}[session][_id]    ${session_id}
    Should Be Equal As Strings    ${reservation}[paymentMethod]    pix
    Should Be Equal As Strings    ${reservation}[status]    confirmed
    Should Be True    ${reservation}[totalPrice] > 1

Test Get Reservation Details Not Found
    [Documentation]    API retorna erro 404 para reserva não encontrada
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login

    ${resp}=    GET Reservation By ID    000000000000000000000000

    Should Be Equal As Numbers    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.json()}[success]    False