*** Settings ***
Documentation    Verify that SSO_admin logon page is not redirected to SP FGT admin logon window after failed SAML_SSO remote admin auth
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${remote_group}    ldapgrp
${remote_admin}    ldapadmin
${remote_admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
${sso_admin_fgtb}    ${USER_LDAP1_USER1}
${ldap1_wrong_password}    654321
${idp_ip}    ${IDP_SERVER_ADDRESS}
*** Test Cases ***
890907
    [Tags]    v6.2    chrome    890907    high
    [setup]    run cli commands in files on terminal server for two FGTs
    ${status}=    Run keyword and return status    Login FortiGate    ${FGTB_URL}    username=${USER_LDAP1_USER1}    password=${ldap1_wrong_password}    auth_type=sso
    #using wrong password, use shouldn't login successfully.
    should not be true    ${status}
    #Authentication failure warning is thrown
    wait until element is visible    ${LOGIN_AUTH_FAILURE}
    #IDP's loggin page should be shown at present.
    ${current_url}=    Get Location
    should contain    ${current_url}    ${idp_ip}
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