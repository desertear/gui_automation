*** Settings ***
Documentation    Verify that password change for remote SSO admin work correctly
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${remote_group}    ldapgrp
${remote_admin}    ldapadmin
${remote_admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
${sso_admin_fgtb}    ${USER_LDAP1_USER2}
${admin_new_password}    123456
&{options_dic}    change_password=${True}    new_password=${admin_new_password}
*** Test Cases ***
891367
    [Tags]    v6.2    chrome    891367    high    bug:0492464    norun
    [setup]    Setup 891367
    Login FortiGate    username=${USER_LDAP1_USER2}    password=${USER_LDAP1_PASSWORD2}    auth_type=password    pki_auth=${False}    &{options_dic}
    Logout FortiGate    ${USER_LDAP1_USER2}
    close browser
    # [Teardown]    case Teardown

*** Keywords ***
Setup 891367
    run cli commands in files on terminal server for two FGTs
    #configure LDAP server: enable passoword-change

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
    #restore LDAP server: restore password and disable passoword-change

    write test result to file    ${CURDIR}