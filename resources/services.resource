*** Settings ***
Documentation    Importa todos os services da API

Resource    services/auth.resource
Resource    services/movies.resource
Resource    services/sessions.resource
Resource    services/theaters.resource
Resource    services/reservations.resource

Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource