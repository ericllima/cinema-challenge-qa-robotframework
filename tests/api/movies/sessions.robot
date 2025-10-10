*** Settings ***
Documentation    Testes de API para gerenciamento de sessões
Library          RequestsLibrary
Resource         ../../../resources/services.resource

Suite Setup      API Session

*** Test Cases ***
Test Get Session By ID
    [Documentation]    Testa busca de sessão por ID
    [Tags]    session_details
    Setup test movies
    Setup test sessions
    
    # Buscar uma sessão para pegar o ID
    ${sessions_resp}=    GET all sessions
    ${session_id}=    Set Variable    ${sessions_resp.json()}[data][0][_id]
    
    ${resp}=    GET session by id    ${session_id}
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Not Be Empty    ${resp.json()}[data]
    
    # Validar estrutura da sessão
    ${session}=    Set Variable    ${resp.json()}[data]
    Should Not Be Empty    ${session}[movie]
    Run Keyword If    'theater' in $session    Should Not Be Empty    ${session}[theater]
    Should Not Be Empty    ${session}[datetime]
    Should Be True    ${session}[fullPrice] > 0
    Should Be True    ${session}[halfPrice] > 0
    Should Not Be Empty    ${session}[seats]
    Should Not Be Empty    ${session}[_id]

Test Get All Sessions
    [Documentation]    Testa listagem de todas as sessões
    [Tags]    sessions_list
    Setup test sessions
    
    ${resp}=    GET all sessions
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Not Be Empty    ${resp.json()}[data]
    
    # Verificar se há sessões dos dois filmes
    ${data}=    Set Variable    ${resp.json()}[data]
    ${length}=    Get Length    ${data}
    Should Be True    ${length} >= 5

Test Get Session By Invalid ID
    [Documentation]    Testa busca de sessão por ID inválido
    [Tags]    session_error
    ${resp}=    GET session by id    507f1f77bcf86cd799439011
    Should Be Equal As Numbers    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Get Sessions For Movie
    [Documentation]    Simula como frontend deve buscar sessões de um filme
    [Tags]    movie_sessions_simulation
    Setup test movies
    Setup test sessions
    
    # Buscar ID do filme Shrek
    ${movies_resp}=    GET all movies
    ${shrek_id}=    Set Variable    ${EMPTY}
    FOR    ${movie}    IN    @{movies_resp.json()}[data]
        IF    '${movie}[title]' == 'Shrek'
            ${shrek_id}=    Set Variable    ${movie}[_id]
            BREAK
        END
    END
    
    # Buscar todas as sessões e filtrar pelo filme
    ${sessions_resp}=    GET all sessions
    ${shrek_sessions}=    Create List
    FOR    ${session}    IN    @{sessions_resp.json()}[data]
        ${movie_id}=    Set Variable    ${session}[movie][_id]
        IF    $movie_id == $shrek_id
            Append To List    ${shrek_sessions}    ${session}
        END
    END
    
    # Validar que encontrou sessões do Shrek
    ${length}=    Get Length    ${shrek_sessions}
    Should Be True    ${length} >= 3
    Log    Encontradas ${length} sessões para o filme Shrek