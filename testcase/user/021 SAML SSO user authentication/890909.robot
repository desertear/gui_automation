*** Settings ***
Documentation    Verify that SSO_admin remote admin logout event clears SSO_admin token in browser 
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${remote_group}    ldapgrp
${remote_admin}    ldapadmin
${remote_admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
${sso_admin_fgtb}    ${USER_LDAP1_USER1}
*** Test Cases ***
890909
    [Tags]    v6.2    chrome    890909    high
    [setup]    run cli commands in files on terminal server for two FGTs
    Login FortiGate    ${FGTB_URL}    username=${USER_LDAP1_USER1}    password=${USER_LDAP1_PASSWORD1}    auth_type=sso
    ${old_handle}=    Open url in new Tab    ${FGTB_URL}
    #judge if admin logs in FGT in new Tab
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${USER_LDAP1_USER1}
    wait until element is visible    ${locator}
    #close current window and switch back to previous window
    Close Window
    select window    ${old_handle}
    #logout FGT in older tab
    Logout FortiGate    ${USER_LDAP1_USER1}
    #go to the FGT again
    Go to    ${FGTB_URL}
    #check if user goes to login page
    Wait Until Element Is Visible    ${SYSTEM_SAML_HREF_ON_LOGIN_PAGE}
    ${status}=    run keyword and return status    wait until element is visible    ${locator}
    should not be true    ${status}
    process authentication for admin    username=${USER_LDAP1_USER1}    password=${USER_LDAP1_PASSWORD1}    auth_type=sso    pki_auth=${False}
    handle different warnings
    check if admin login successfully    ${USER_LDAP1_USER1}
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