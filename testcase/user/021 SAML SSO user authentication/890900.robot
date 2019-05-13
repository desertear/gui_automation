*** Settings ***
Documentation    Verify that SAML SSO remote 2FA FTM admin can logon to SP FGT (#0539741)
Resource    ../user_resource.robot
Library    AppiumLibrary
Suite Setup    Set Library Search Order    SeleniumLibrary    AppiumLibrary
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${admin_group}    admingrp
${token_admin}    tokenadmin
${token_admin_password}    1
${token_admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
${sso_admin_fgtb}    ${token_admin}
@{cmd}    show user fortitoken ${USER_FORTITOKEN_SN1}
&{options_dic}    fortitoken_mobile=${True}

*** Test Cases ***
890900
    [Tags]    v6.2    chrome    890900    critical    mobile_token
    [setup]    run cli commands in files on terminal server for two FGTs
    ${activation_code}=    Get FTM Activation Code    ${cmd}
    Add key to FotiTokenMobile    test    ${activation_code}
    Login FortiGate Using Token    ${FGTB_URL}    username=${token_admin}    password=${token_admin_password}    auth_type=sso    pki_auth=${False}    &{options_dic}
    #when logging out, below keywords will check the username.
    Logout FortiGate    ${token_admin}
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
