*** Variables ***
# URLs
${BASE_URL}                http://localhost:3002
${API_BASE_URL}            http://localhost:3000/api/v1/

# Timeouts
${DEFAULT_TIMEOUT}         10s
${API_TIMEOUT}             5s
${PAGE_LOAD_TIMEOUT}       20s

# Browser Settings
${BROWSER}                 chromium
${HEADLESS}                False

# Test Data Files
${TEST_DATA_DIR}           ${CURDIR}/../fixtures