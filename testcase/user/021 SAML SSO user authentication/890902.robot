*** Settings ***
Documentation    Verify that SAML SSO remote pki admin can log on to SP FGT
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${pki_peer_name}    pki
${pki_ca}    ${FGT_CA_NAME}
${pki_peer_cn}    *.fos.automation.com
${pki_group}    pkigrp
${pki_admin}    pkiadmin
${pki_admin_profile}    super_admin
${pki_admin_profile_fgtb}    super_admin
${pki_admin_fgtb}    ${pki_admin}
*** Test Cases ***
890902
    [Tags]    v6.2    chrome    890902    critical
    [setup]    run cli commands in files on terminal server for two FGTs
    #Warning: In order to run this case, need to add certificate to Chrome and 
    #configure "{\"pattern\":\"https://10.1.100.1:1443\",\"filter\":{\"ISSUER\":{\"CN\":\"FOS GUI Automation Root CA\"}}}" on registry of Windows.
    Login FortiGate    ${FGTB_URL}    username=${pki_admin}    password=${EMPTY}    auth_type=sso    pki_auth=${True}
    #when logging out, below keywords will check the username.
    Logout FortiGate    ${pki_admin}    auth_type=sso    pki_auth=${True}
    close browser
    [Teardown]    case Teardown

*** Keywords ***
run cli commands in files on terminal server for two FGTs
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_setup_cli.txt
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_setup_cli.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    


case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_teardown_cli.txt
    write test result to file    ${CURDIR}