*** Settings ***
Documentation    Testes de navegação e detalhes de filmes (US-MOVIE-001 e US-MOVIE-002)
Resource         ../../resources/base.resource

Test Setup      Setup Browser
Test Teardown   Take Screenshot

*** Test Cases ***
Test Movies List Display
    [Documentation]    Lista de filmes exibe corretamente em grid (US-MOVIE-001)
    
    Go To    ${BASE_URL}/movies

    Wait For Elements State    css=.movies-container    visible    timeout=${TIMEOUT}

    Wait For Elements State    css=.movies-grid    visible    timeout=${TIMEOUT}

    ${count}=    Get Element Count    css=.movie-card
    Should Be True    ${count} > 0

    Wait For Elements State    css=.movie-card:first-child img    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-card:first-child .movie-title    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-card:first-child .movie-genres    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-card:first-child .movie-meta    visible    timeout=${TIMEOUT}

Test Movies Grid Responsive
    [Documentation]    Grid de filmes se adapta a diferentes telas (US-MOVIE-001)
    [Tags]    movies    responsive
    
    Go To    ${BASE_URL}/movies

    Set Viewport Size    1920    1080
    Wait For Elements State    css=.movies-grid    visible    timeout=${TIMEOUT}

    Set Viewport Size    768    1024
    Wait For Elements State    css=.movies-grid    visible    timeout=${TIMEOUT}

    Set Viewport Size    375    667
    Wait For Elements State    css=.movies-grid    visible    timeout=${TIMEOUT}

Test Movie Card Click Navigation
    [Documentation]    Clique no card do filme navega para detalhes (US-MOVIE-001)
    [Tags]    movies    navigation
    
    Go To    ${BASE_URL}/movies

    Wait For Elements State    css=.movie-card:first-child .btn    visible    timeout=${TIMEOUT}
    Click    css=.movie-card:first-child .btn

    Wait For Elements State    css=.movie-detail-header    visible    timeout=${TIMEOUT}
    ${current_url}=    Get Url
    Should Match Regexp    ${current_url}    /movies/[a-f0-9]{24}

Test Movie Details Page
    [Documentation]    Página de detalhes exibe informações completas (US-MOVIE-002)
    [Tags]    movies    details

    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card:first-child .btn    visible    timeout=${TIMEOUT}
    Click    css=.movie-card:first-child .btn

    Wait For Elements State    css=.movie-detail-header    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-poster    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-info h1    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-synopsis    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.movie-meta    visible    timeout=${TIMEOUT}

Test Movie Sessions Display
    [Documentation]    Página de detalhes exibe horários de sessões (US-MOVIE-002)
    [Tags]    movies    sessions

    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card:first-child .btn    visible    timeout=${TIMEOUT}
    Click    css=.movie-card:first-child .btn

    Wait For Elements State    css=.sessions-container    visible    timeout=${TIMEOUT}
    ${text}=    Get Text    css=.sessions-container h2
    Should Contain    ${text}    Sessões

    ${session_count}=    Get Element Count    css=.session-card
    Should Be True    ${session_count} > 0

Test Navigate To Booking From Sessions
    [Documentation]    Usuário pode navegar para reserva a partir dos horários (US-MOVIE-002)
    [Tags]    movies    booking

    Go To    ${BASE_URL}/movies
    Wait For Elements State    css=.movie-card:first-child .btn    visible    timeout=${TIMEOUT}
    Click    css=.movie-card:first-child .btn

    Wait For Elements State    css=.session-card:first-child .btn    visible    timeout=${TIMEOUT}
    Click    css=.session-card:first-child .btn

    ${current_url}=    Get Url
    Should Match Regexp    ${current_url}    /sessions/[a-f0-9]{24}