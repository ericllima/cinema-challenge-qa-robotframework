*** Settings ***
Documentation    Ações e elementos do cabeçalho

Library    String
Library    Browser

*** Keywords ***
User should be logged In
    [Arguments]    ${name}

    @{splited_name}    Split String    ${name}
    ${element}    Set Variable    css=header button:has-text("Sair")

    Wait For Elements State    ${element}
    ...    visible    5

    Get Text    ${element}    equal    Sair

Go to task form
    Click    css=.button-add