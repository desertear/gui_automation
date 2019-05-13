*** Settings ***
Documentation    Verify that password change for local SSO_admin works OK 
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${admin_username}    testadmin
${admin_password}    12345678
${admin_new_password}    87654321
${admin_profile}    super_admin
${sso_admin_profile_fgtb}    super_admin
@{cmd}    config system password-policy    unset status    end
&{options_dic}    change_password=${True}    new_password=${admin_new_password}
*** Test Cases ***
891191
    [Tags]    v6.2    chrome    891191    high
    [setup]    run cli commands in files on terminal server for two FGTs
    Login FortiGate    username=${admin_username}    password=${admin_password}    auth_type=password    pki_auth=${False}    &{options_dic}
    Logout FortiGate    ${admin_username}
    close browser
    [Teardown]    case Teardown

*** Keywords ***
run cli commands in files on terminal server for two FGTs
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_setup_cli.txt
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_setup_cli.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    

case Teardown
    #disable password policy for admin firstly
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd}    username=${admin_username}    password=${admin_new_password}
    ${response}=    Convert List to String    ${response_list}
    Should Not Contain Any    ${response}    Login incorrect    Unknown action    Command fail    operator error
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgtb_teardown_cli.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_fgta_teardown_cli.txt
    write test result to file    ${CURDIR}