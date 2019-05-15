*** Settings ***
Documentation    Verify that multiple LDAP server( FGT LDAP user) and multiple group matches work for user authentication 
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
${ldap1_group_check}    ${USER_LDAP1_GROUP_MEMBER_CHECK}
${ldap1_group_cn}    CN=${USER_LDAP1_GROUP1},${USER_LDAP1_GROUP_SEARCH_BASE}
#LDAP Server2
${ldap2_name}    ${USER_LDAP2_NAME}
${ldap2_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap2_port}    ${USER_LDAP2_SERVER_PORT}
${ldap2_cn}    ${USER_LDAP2_CNID}
${ldap2_dn}    ${USER_LDAP2_DN}
${ldap2_username}    ${USER_LDAP2_USERNAME}
${ldap2_password}    ${USER_LDAP2_PASSWORD}
${ldap2_group_check}    ${USER_LDAP2_GROUP_MEMBER_CHECK}
${ldap2_group_object_filter}    ${USER_LDAP2_GROUP_OBJECT_FILTER}
${ldap2_group_cn}    CN=${USER_LDAP2_GROUP1},${USER_LDAP2_GROUP_SEARCH_BASE}
#variables to create group
${group_name1}    ldapgroup1
${group_name2}    ldapgroup2
${admin_name1}    ldapadmin1
${admin_name2}    ldapadmin2

*** Test Cases ***
754592
    [Tags]    v6.2    chrome    754592    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    username=${USER_LDAP1_USER1}    password=${USER_LDAP1_PASSWORD1}
    Logout FortiGate    username=${USER_LDAP1_USER1}
    Close Browser
    Login FortiGate    username=${USER_LDAP2_USER1}    password=${USER_LDAP2_PASSWORD1}
    Logout FortiGate    username=${USER_LDAP2_USER1}
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}