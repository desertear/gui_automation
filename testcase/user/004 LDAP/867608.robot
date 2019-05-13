*** Settings ***
Documentation    Verify that FGT does not allow empty password in case LDAP is used for user credential verification (#0487841 ) 
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ldap_name}    ${USER_LDAP2_NAME}
${ldap_address}    ${USER_LDAP2_SERVER_ADDR}
${ldap_port}    ${USER_LDAP2_SERVER_PORT}
${ldap_cn}    ${USER_LDAP2_CNID}
${ldap_dn}    ${USER_LDAP2_DN}
${ldap_bind_type}    Regular
${ldap_username}    ${USER_LDAP2_USERNAME}
${ldap_password}    ${USER_LDAP2_PASSWORD}
@{arg}    ${USER_LDAP2_USER3}    ${USER_LDAP2_PASSWORD3}
*** Test Cases ***
867608
    [Tags]    v6.2    chrome    867608    high
    Login FortiGate
    Create New LDAP Server    ${ldap_name}    ${ldap_address}    ${ldap_port}    ${ldap_cn}
    ...    ${ldap_dn}    ${ldap_bind_type}    ${ldap_username}    ${ldap_password}
    test ldap server user credentials with empty password    ${ldap_name}    @{arg}
    Delete LDAP Server    ${USER_LDAP2_NAME}
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}

test ldap server user credentials with empty password
    [Arguments]    ${ldap_server_name}    ${username}    ${password}
    Go to User and Device
    Go to LDAP Servers
    ${status}=    If LDAP Server exists    ${ldap_server_name}
    Should be True    ${status}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_LDAP_SERVERS_IN_TABLE}    ${ldap_server_name}
    click element    ${locator}
    Click button    ${USER_LDAP_SERVERS_EDIT_BUTTON}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_EDIT_H1}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_BUTTON}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_BUTTON}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_HEAD}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    
    Input Text    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    ${username}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    
    Input Text    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    ${password}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_TEST_BUTTON}
    Wait Until Element Is Visible     ${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_EMPTY_WARNING}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_CLOSE_BUTTON}
    Wait Until Element is not Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_HEAD}
    click button    ${USER_LDAP_SERVERS_USER_OK}
    #verify if the user is updated successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    [Teardown]    Unselect Frame