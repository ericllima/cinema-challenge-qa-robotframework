*** Settings ***
Documentation    Cinema Challenge Test Suite
...              Automação de testes para sistema de cinema
...              
...              Estrutura:
...              - API Tests: Testes de endpoints REST
...              - Web Tests: Testes de interface
...              - E2E Tests: Testes de ponta a ponta

Suite Setup      Log    Iniciando execução dos testes Cinema Challenge
Suite Teardown   Log    Finalizando execução dos testes Cinema Challenge