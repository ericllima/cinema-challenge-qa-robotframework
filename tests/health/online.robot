*** Settings ***
Documentation    Testa conectividade com URLs do sistema
Resource         ../../resources/base.resource

*** Test Cases ***
Test API Connectivity
    [Documentation]    Verifica se a API está online
    Create Session    api    ${API_BASE_URL}
    ${response}=    GET On Session    api    /    expected_status=any
    Should Be True    ${response.status_code} < 500
    Delete All Sessions

Test Web Connectivity
    [Documentation]    Verifica se a aplicação web está online
    Setup Browser
    Get Title    equal    Cinema App