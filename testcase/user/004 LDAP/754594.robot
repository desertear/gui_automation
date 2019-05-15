*** Settings ***
Documentation    Verify that ldap-browser in FW-group config GUI can still browse the tree if secondary LDAP server takes over ( #218597 )
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
#LDAP Server1
${ldap1_name}    ${USER_LDAP1_NAME}
${ldap1_Fake_address}    2.2.2.2
${ldap1_sec_address}    ${USER_LDAP1_SERVER_ADDR}
${ldap1_port}    ${USER_LDAP1_SERVER_PORT}
${ldap1_cn}    ${USER_LDAP1_CNID}
${ldap1_dn}    ${USER_LDAP1_DN}
${ldap1_username}    ${USER_LDAP1_USERNAME}
${ldap1_password}    ${USER_LDAP1_PASSWORD}
@{remote_groups1}    ${USER_LDAP1_GROUP1}    ${USER_LDAP1_GROUP2}
#variables to create group
&{remote_server1}    server_type=ldap    server_name=ad    remote_groups=@{remote_groups1}
@{remote_servers}    ${remote_server1}
${group_name}    usergroup

*** Test Cases ***
754594
    [Tags]    v6.2    chrome    754594    high
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