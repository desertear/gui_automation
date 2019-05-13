*** Settings ***
Documentation    Verify that remote wildcard admin account can be used with actual user name for SAML SSO admin logon to SP FGT
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${remote_group}    ldapgrp
${remote_admin}    ldapadmin
${remote_admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
${sso_admin_fgtb}    ${USER_LDAP1_USER1}
*** Test Cases ***
890898
    [Tags]    v6.2    chrome    890898    critical
    [setup]    run cli commands in files on terminal server for two FGTs
    Login FortiGate    ${FGTB_URL}    username=${USER_LDAP1_USER1}    password=${USER_LDAP1_PASSWORD1}    auth_type=sso
    #when logging out, below keywords will check the username.
    Logout FortiGate    ${USER_LDAP1_USER1}
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