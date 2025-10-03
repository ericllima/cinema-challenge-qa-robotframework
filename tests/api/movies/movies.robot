*** Settings ***
Documentation    Testes de API para gerenciamento de filmes
Library          RequestsLibrary
Resource         ../../../resources/services.resource

Suite Setup      API Session

*** Test Cases ***
Test Get All Movies
    [Documentation]    Testa listagem de todos os filmes
    Setup test movies
    
    ${resp}=    GET all movies
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Not Be Empty    ${resp.json()}[data]
    ${length}=    Get Length    ${resp.json()}[data]
    Should Be True    ${length} == 2

    FOR    ${movie}    IN    @{resp.json()}[data]
        IF    '${movie}[title]' == 'Shrek'
            Should Be Equal As Strings    ${movie}[classification]    Livre
            Should Be Equal As Numbers    ${movie}[duration]    90
            Should Contain    ${movie}[releaseDate]    2025-10-13
            Should Contain    ${movie}[poster]    shrek
            BREAK
        END
    END


Test Get Movie By Valid ID
    [Documentation]    Testa busca de filme por ID válido
    ${interestelar}=    Get Fixtures    movies    interestelar
    ${movie_id}=    Reset movie from database    ${interestelar}
    
    ${resp}=    GET movie by id    ${movie_id}
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be Equal As Strings    ${resp.json()}[data][title]    ${interestelar}[title]

Test Get Movie By Invalid ID
    [Documentation]    Testa busca de filme por ID inválido
    ${resp}=    GET movie by id    invalid_movie_id
    Should Be Equal As Numbers    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.json()}[success]    False
