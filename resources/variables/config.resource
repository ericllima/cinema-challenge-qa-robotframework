*** Settings ***
Documentation    Variaveis globais e configurações de ambiente

*** Variables ***
# URLs
${BASE_URL}                http://localhost:3002
${API_BASE_URL}            http://localhost:3000/api/v1

# Timeouts
${TIMEOUT}    8
${API_TIMEOUT}    5
${PAGE_TIMEOUT}    10

# Browser Settings
${BROWSER}                 chromium
${HEADLESS}                False

# Test Data Files
${TEST_DATA_DIR}           ${EXECDIR}/resources/fixtures/