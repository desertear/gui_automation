*** Settings ***
Documentation    Verify that group members of groups that are not selected/added by LDAP browser  to firewall group can not connect authenticate
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
${group_cn}    CN=${USER_LDAP1_GROUP1},${USER_LDAP1_GROUP_SEARCH_BASE}
${group_name}    ldapgroup
${admin_name}    ldapadmin

*** Test Cases ***
751486
    [Tags]    v6.2    chrome    751486    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    username=${USER_LDAP1_USER1}    password=${USER_LDAP1_PASSWORD1}
    Logout FortiGate    username=${USER_LDAP1_USER1}
    Close Browser
    ${status}=    Run keyword and return status    Login FortiGate    username=${USER_LDAP1_USER2}    password=${USER_LDAP1_PASSWORD2}
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}