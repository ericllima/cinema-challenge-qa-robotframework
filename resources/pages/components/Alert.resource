*** Settings ***
Documentation    Ações e elementos de notificações/alertas

Library    Browser

*** Keywords ***
Should Show Success Message
    [Arguments]    ${message}
    [Documentation]    Valida que mensagem de sucesso é exibida
    
    Wait For Elements State    css=.alert-success    visible    timeout=5
    Get Text    css=.alert-success .alert-content    equal    ${message}

Should Show Error Message
    [Arguments]    ${message}
    [Documentation]    Valida que mensagem de erro é exibida

    Wait For Elements State    css=.alert-error    visible    timeout=5
    Get Text    css=.alert-error .alert-content    equal    ${message}