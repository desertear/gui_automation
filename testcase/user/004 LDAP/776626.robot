*** Settings ***
Documentation    Verify that multi-selection of users in step 3 of user creation wizzard works correctly
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP2_NAME}
${ldap_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap_port}    ${USER_LDAP2_SERVER_PORT}
${ldap_cn}    ${USER_LDAP2_CNID}
${ldap_dn}    ${USER_LDAP2_DN}
${ldap_username}    ${USER_LDAP2_USERNAME}
${ldap_password}    ${USER_LDAP2_PASSWORD}
@{ldap_users}    ${USER_LDAP2_USER1}    ${USER_LDAP2_USER2}
&{dic2}    ldap_server=${ldap_name}    ldap_remote_users=${ldap_users}
@{cmd_correct_pwd}    diagnose test authserver local '' ${USER_LDAP2_USER1} ${USER_LDAP2_PASSWORD1}
@{cmd_wrong_pwd}    diagnose test authserver local '' ${USER_LDAP2_USER2} ${USER_LDAP2_PASSWORD2}


*** Test Cases ***
776626
    [Tags]    v6.2    chrome    776626    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Create new user    Remote LDAP User    &{dic2}    
    Logout FortiGate
    Close Browser
    #user debug command to verify the user authentication
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_correct_pwd}
    Should Contain     @{response_list}[-1]    succeeded
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_wrong_pwd}
    Should Contain     @{response_list}[-1]    succeeded
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}