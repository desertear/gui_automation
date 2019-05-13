*** Settings ***
Documentation    Verify PKI user can the authentication and login
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${browser}    Chrome
${part_of_username}    ${FGT_PKI_PEER_NAME}
${url}    ${FGT_URL}
${logout_message}    You have logged out. It is recommended to close the window for security reasons.
*** Test Cases ***
730939
    [Documentation]   
    #Warning: In order to run this case, need to add certificate to Chrome and 
    #configure "{\"pattern\":\"https://10.1.100.1:443\",\"filter\":{\"ISSUER\":{\"CN\":\"FOS GUI Automation Root CA\"}}}" on registry of Windows.
    # registry path: \HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\AutoSelectCertificateForUrls
    [Tags]    chrome    730939    high    preconfig    no_grid    
    [setup]    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    ##Login FGT
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    click button    ${FIPS_ACCEPT_BUTTON}
    Wait Until Keyword Succeeds    3x    2s    Element Text Should Be    ${PLTF_TYPE_DIV}    ${FGT_HW_TYPE}
    ##Logout FGT
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${FGT_PKI_ADMIN_NAME}
    click button    ${locator}
    sleep    1
    click button    ${LOGOUT_LOGOUT_BUTTON}
    Wait Until Page contains    ${logout_message}


*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}