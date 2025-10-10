*** Settings ***
Documentation    Testes da página inicial (US-HOME-001)
Resource         ../../resources/base.resource

Test Setup      Setup Browser
Test Teardown   Take Screenshot

*** Test Cases ***
Test Home Page Load
    [Documentation]    Página inicial carrega com elementos principais visíveis
    [Tags]    home    navigation
    
    Go To    ${BASE_URL}

    Wait For Elements State    css=.home-container h1    visible    timeout=${TIMEOUT}
    ${title_text}=    Get Text    css=.home-container h1
    Should Contain    ${title_text}    Welcome to Cinema App

    Wait For Elements State    css=.featured-movies    visible    timeout=${TIMEOUT}
    ${section_text}=    Get Text    css=.featured-movies h2
    Should Contain    ${section_text}    Filmes em Cartaz

    Wait For Elements State    css=header .nav    visible    timeout=${TIMEOUT}

    Wait For Elements State    css=.features-section    visible    timeout=${TIMEOUT}
    
Test Home Page Navigation Links
    [Documentation]    Links de navegação funcionam corretamente
    
    Go To    ${BASE_URL}

    Click    css=header nav a[href="/movies"]
    ${current_url}=    Get Url
    Should Contain    ${current_url}    /movies

    Go To    ${BASE_URL}

    Click    css=header nav a[href="/"]:has-text("Início")
    ${current_url}=    Get Url
    Should Contain    ${current_url}    ${BASE_URL}

Test Home Page Responsive Layout
    [Documentation]    Layout se adapta a diferentes tamanhos de tela
    
    Go To    ${BASE_URL}

    Set Viewport Size    1920    1080
    Wait For Elements State    css=.featured-movies    visible    timeout=${TIMEOUT}

    Set Viewport Size    375    667
    Wait For Elements State    css=.mobile-toggle    visible    timeout=${TIMEOUT}
    Wait For Elements State    css=.featured-movies    visible    timeout=${TIMEOUT}