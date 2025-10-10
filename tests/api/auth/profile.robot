*** Settings ***
Documentation    Testes de API para gerenciamento de perfil do usuário (US-AUTH-004)
Library          RequestsLibrary
Resource         ../../../resources/services.resource
Resource         ../../../resources/services/auth.resource

Suite Setup      API Session

*** Test Cases ***
Test Get Profile With Valid Token
    [Documentation]    API GET /auth/me retorna dados do usuário
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    GET    url=${API_BASE_URL}/auth/me    headers=${headers}    expected_status=any

    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be Equal As Strings    ${resp.json()}[data][name]    ${user}[name]
    Should Be Equal As Strings    ${resp.json()}[data][email]    ${user}[email]
    Dictionary Should Contain Key    ${resp.json()}[data]    role
    Dictionary Should Contain Key    ${resp.json()}[data]    _id

#A chave "erro" não existe. Retorna "message"
Test Get Profile Without Token
    [Documentation]    API retorna erro 401 para usuários não autenticados
    ${resp}=    GET    url=${API_BASE_URL}/auth/me    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()}[success]    False
    Dictionary Should Contain Key    ${resp.json()}    error

#A chave "erro" não existe. Retorna "message"
Test Get Profile With Invalid Token
    [Documentation]    API retorna erro 403 para token inválido
    ${headers}=    Create Dictionary    Authorization=Bearer invalid_token
    ${resp}=    GET    url=${API_BASE_URL}/auth/me    headers=${headers}    expected_status=any

    Should Be Equal As Strings    ${resp.json()}[success]    False
    Should Be Equal As Numbers    ${resp.status_code}    403
    Dictionary Should Contain Key    ${resp.json()}    error

# =======PUT /auth/profile - Update user profile========
Test Update Profile Name Success
    [Documentation]    API PUT /auth/profile permite atualizar nome do usuário
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${new_name}=    Set Variable    Updated User Name
    ${body}=    Create Dictionary    name=${new_name}
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be Equal As Strings    ${resp.json()}[data][name]    ${new_name}

Test Update Profile Without Token
    [Documentation]    API retorna erro 401 para usuários não autenticados
    ${body}=    Create Dictionary    name=New Name
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Update Profile With Empty Name
    [Documentation]    API aceita nome vazio (comportamento atual)
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    name=${EMPTY}
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True

Test Update Profile With Only Spaces Name
    [Documentation]    API rejeita nome com apenas espaços
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${spaces_name}=    Set Variable    ${SPACE}${SPACE}${SPACE}
    ${body}=    Create Dictionary    name=${spaces_name}
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Cannot Update Email Via Profile
    [Documentation]    Sistema ignora tentativa de alteração de e-mail via API
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    name=Valid Name    email=newemail@test.com
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be Equal As Strings    ${resp.json()}[data][name]    Valid Name

Test Cannot Update Role Via Profile
    [Documentation]    Sistema ignora tentativa de alteração de função via API
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    name=Valid Name    role=admin
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True
    Should Be Equal As Strings    ${resp.json()}[data][name]    Valid Name

Test Update Password Success
    [Documentation]    API permite alterar senha com senha atual correta
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    currentPassword=${user}[password]    newPassword=newPassword123
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()}[success]    True

Test Update Password With Wrong Current Password
    [Documentation]    API retorna erro 401 para senha atual incorreta
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    currentPassword=wrongPassword    newPassword=newPassword123
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.json()}[success]    False

Test Update Password Without Current Password
    [Documentation]    API requer senha atual para alterar senha
    ${user}=    Get Fixtures    users    valid_user
    Reset user from database    ${user}
    POST a user login
    
    ${headers}=    Create Dictionary    Authorization=${token}    Content-Type=application/json
    ${body}=    Create Dictionary    newPassword=newPassword123
    
    ${resp}=    PUT    url=${API_BASE_URL}/auth/profile    headers=${headers}    json=${body}    expected_status=any
    
    Should Be Equal As Numbers    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.json()}[success]    False