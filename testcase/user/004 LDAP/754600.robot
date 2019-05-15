*** Settings ***
Documentation    Verify that default LDAP filter in LDAP User Wizzard works for OpenLDAP and AD when mapping remote LDAP users to local users
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
#LDAP Server1
${ldap1_name}    ${USER_LDAP1_NAME}
${ldap1_address}    ${USER_LDAP1_SERVER_ADDR}
${ldap1_port}    ${USER_LDAP1_SERVER_PORT}
${ldap1_cn}    ${USER_LDAP1_CNID}
${ldap1_dn}    ${USER_LDAP1_DN}
${ldap1_username}    ${USER_LDAP1_USERNAME}
${ldap1_password}    ${USER_LDAP1_PASSWORD}
@{ldap1_users}    ${USER_LDAP1_USER1}    ${USER_LDAP1_USER2}
&{dic1}    ldap_server=${ldap1_name}    ldap_remote_users=${ldap1_users}
#LDAP Server2
${ldap2_name}    ${USER_LDAP2_NAME}
${ldap2_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap2_port}    ${USER_LDAP2_SERVER_PORT}
${ldap2_cn}    ${USER_LDAP2_CNID}
${ldap2_dn}    ${USER_LDAP2_DN}
${ldap2_username}    ${USER_LDAP2_USERNAME}
${ldap2_password}    ${USER_LDAP2_PASSWORD}
@{ldap2_users}    ${USER_LDAP2_USER1}    ${USER_LDAP2_USER2}
&{dic2}    ldap_server=${ldap2_name}    ldap_remote_users=${ldap2_users}
@{cmd_pwd1}    diagnose test authserver local '' ${USER_LDAP1_USER1} ${USER_LDAP1_PASSWORD1}
@{cmd_pwd2}    diagnose test authserver local '' ${USER_LDAP1_USER2} ${USER_LDAP1_PASSWORD2}
@{cmd_pwd3}    diagnose test authserver local '' ${USER_LDAP2_USER1} ${USER_LDAP2_PASSWORD1}
@{cmd_pwd4}    diagnose test authserver local '' ${USER_LDAP2_USER2} ${USER_LDAP2_PASSWORD2}
*** Test Cases ***
754600
    [Tags]    v6.2    chrome    754600    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Create new user    Remote LDAP User    &{dic1}
    Create new user    Remote LDAP User    &{dic2} 
    Logout FortiGate
    Close Browser
    #user debug command to verify the user authentication
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_pwd1}
    Should Contain     @{response_list}[-1]    succeeded
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_pwd2}
    Should Contain     @{response_list}[-1]    succeeded
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_pwd3}
    Should Contain     @{response_list}[-1]    succeeded
    ${response_list}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_pwd4}
    Should Contain     @{response_list}[-1]    succeeded
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}