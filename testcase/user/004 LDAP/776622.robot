*** Settings ***
Documentation    Verify that only users are shown in selection box for remote LDAP users in step 3 of user creation wizzard
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
${ldap_user1}    ${USER_LDAP2_USER1}
${ldap_user2}    ${USER_LDAP2_USER2}
${ldap_group1}    group3
${ldap_group2}    group4
&{data_dic}    ldap_server=${ldap_name}

*** Test Cases ***
776622
    [Tags]    v6.2    chrome    776622    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    Go to User and Device
    Go to User Definition
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    choose user type in step one    Remote LDAP User
    config user in step two    Remote LDAP User    &{data_dic}
    Wait Until Element is Visible    ${USER_USER_LDAP_SERVER_BROWSER}
    #users should be displayed
    ${user_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${ldap_user1}
    Wait Until Element is Visible    ${user_locator}
    ${user_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${ldap_user2}
    Wait Until Element is Visible    ${user_locator}
    #groups should not be displayed
    ${group_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${ldap_group1}
    Wait Until Element is Not Visible    ${group_locator}
    ${group_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${ldap_group2}
    Wait Until Element is Not Visible    ${group_locator}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}