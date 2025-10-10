*** Settings ***
Documentation    Testes para sistema de reservas
Resource         ../../resources/base.resource
Suite Setup      Setup Test Data
Test Setup       Setup Browser And Login
Test Teardown    Close Browser

*** Keywords ***
Setup Test Data
    Setup Test Movies
    Setup Test Sessions
    Clean Reservations From Database
    ${user}=    Get Fixtures    users    valid_user
    Clean User From Database    ${user}[email]
    Insert User Into Database    ${user}

Setup Browser And Login
    Setup Browser
    ${user}=    Get Fixtures    users    valid_user
    Do Login    ${user}

*** Test Cases ***
Should Make Complete Reservation
    [Documentation]    Realiza uma reserva completa do filme

    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card >> nth=0    visible

    Click    css=.movie-card >> nth=0 >> css=a
    Wait For Elements State    css=.sessions-container    visible

    Click    css=.session-card >> nth=0 >> css=a
    Wait For Elements State    css=.seats-container    visible

    Click    css=.seat.available >> nth=0
    Click    css=.seat.available >> nth=1

    Click    css=.checkout-button
    Wait For Elements State    css=.checkout-container    visible

Should Display Seat Selection
    [Documentation]    Verifica exibição da seleção de assentos
    
    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card >> nth=0    visible
    
    Click    css=.movie-card >> nth=0 >> css=a
    Wait For Elements State    css=.sessions-container    visible
    
    Click    css=.session-card >> nth=0 >> css=a
    Wait For Elements State    css=.seats-container    visible
    
    ${seat_count}=    Get Element Count    css=.seat
    Should Be True    ${seat_count} > 0
    
    Wait For Elements State    css=.seat.available >> nth=0    visible

Should Calculate Total Price
    [Documentation]    Verifica cálculo do preço total
    
    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card >> nth=0    visible
    
    Click    css=.movie-card >> nth=0 >> css=a
    Wait For Elements State    css=.sessions-container    visible
    
    Click    css=.session-card >> nth=0 >> css=a
    Wait For Elements State    css=.seats-container    visible
    
    Click    css=.seat.available >> nth=0
    Wait For Elements State    css=.price    visible
    
    Get Text    css=.price    contains    R$