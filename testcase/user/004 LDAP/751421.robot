*** Settings ***
Documentation    Verify that groups can be modified / deleted  with the LDAP browser for firewall group creation
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
${ldap1_group_cn1}    CN=${USER_LDAP1_GROUP1},${USER_LDAP1_GROUP_SEARCH_BASE}
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
${ldap2_group_cn1}    cn=${USER_LDAP2_GROUP1},${USER_LDAP2_GROUP_SEARCH_BASE}
${ldap2_group_cn2}    cn=${USER_LDAP2_GROUP2},${USER_LDAP2_GROUP_SEARCH_BASE}
@{original_ldap2_groups}    ${USER_LDAP2_GROUP1}    ${USER_LDAP2_GROUP2}
@{new_ldap2_groups}    ${USER_LDAP2_GROUP2}
#variables to create group
${group_name}    ldapgroup
${admin_name}    ldapadmin

*** Test Cases ***
751421
    [Tags]    v6.2    chrome    751421    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Go to User and Device
    Go to User Groups
    ${locator_group_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_GROUP_IN_TABLE}    ${group_name} 
    wait until page contains element    ${locator_group_in_table}
    Click Element    ${locator_group_in_table}
    Wait Until Element Is Visible    ${GROUP_CREATE_EDIT_BUTTON}
    click button    ${GROUP_CREATE_EDIT_BUTTON}
    Wait Until Element Is Visible    ${GROUP_EDIT_H1}
    #delete one remote group
    delete remote group from user group    ${ldap1_name}
    #edit one remote group
    &{dic_data}=    Create Dictionary    server_name=${ldap2_name}    original_remote_groups=@{original_ldap2_groups}    remote_groups=@{new_ldap2_groups}
    edit ldap remote group for user group    &{dic_data}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}