*** Settings ***
Documentation    Verify that more than one LDAP server can be used by LDAP browser for firewall group creation
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
@{remote_groups1}    ${USER_LDAP1_GROUP1}    ${USER_LDAP1_GROUP2}
#LDAP Server2
${ldap2_name}    ${USER_LDAP2_NAME}
${ldap2_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap2_port}    ${USER_LDAP2_SERVER_PORT}
${ldap2_cn}    ${USER_LDAP2_CNID}
${ldap2_dn}    ${USER_LDAP2_DN}
${ldap2_username}    ${USER_LDAP2_USERNAME}
${ldap2_password}    ${USER_LDAP2_PASSWORD}
@{remote_groups2}    ${USER_LDAP2_GROUP1}    ${USER_LDAP2_GROUP2}
#variables to create group
&{remote_server1}    server_type=ldap    server_name=ad    remote_groups=@{remote_groups1}
&{remote_server2}    server_type=ldap    server_name=openldap    remote_groups=@{remote_groups2}
@{remote_servers}    ${remote_server1}    ${remote_server2}
${group_name}    usergroup

*** Test Cases ***
751422
    [Tags]    v6.2    chrome    751422    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Create new group    firewall    ${group_name}    @{EMPTY}    remote_groups=@{remote_servers}
    Delete Group    ${group_name}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}