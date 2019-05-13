*** Settings ***
Documentation     This file contains all operations on User->LDAP Servers

*** Keywords ***
###User & Device###
##User & Device ->LDAP Servers##
Go to LDAP Servers
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_ENTRY}
    click element    ${USER_LDAP_SERVERS_ENTRY}


Create New LDAP Server
    [Arguments]    ${ldap_server_name}     ${server_ip}    ${server_port}    ${common_name}    ${distinguished_name}
    ...    ${bind_type}=Simple    ${username}=${EMPTY}    ${password}=${EMPTY}
    ...    ${secure_connection}=${False}    ${protocol}=STARTTLS    ${certificate}=${EMPTY}
    Go to User and Device
    Go to LDAP Servers
    ${status}=    If LDAP Server exists    ${ldap_server_name}
    run keyword if    "${status}"=="True"     Delete LDAP Server    ${ldap_server_name}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_LDAP_SERVERS_CREATE_NEW}
    unselect frame
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_EDIT_H1}
    set or change ldap name    ${ldap_server_name}
    set or change ldap server ip    ${server_ip}
    set or change ldap server port    ${server_port}
    set or change ldap Common Name    ${common_name}
    set or change ldap Distinguished Name    ${distinguished_name}
    set or change ldap server bind type    ${bind_type}
    Run keyword if    "${bind_type}"=="Regular"    set or change ldap regular username    ${username}
    Run keyword if    "${bind_type}"=="Regular"    set or change ldap regular password    ${password}
    set or change ldap server secure connection    ${secure_connection}
    Run keyword if    ${secure_connection}    set or change ldap server protocol    ${protocol}
    Run keyword if    "${certificate}"!="${EMPTY}"    choose or change ldap server certificate    ${certificate}    
    click button    ${USER_LDAP_SERVERS_USER_OK}
    #verify if the user is created successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CREATE_NEW}
    ${locator_ldap_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_LDAP_SERVERS_IN_TABLE}    ${ldap_server_name}
    Wait Until Element Is Visible    ${locator_ldap_server_in_table}
    [teardown]    unselect frame


If LDAP Server exists
    [Arguments]    ${ldap_server}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CREATE_NEW}
    ${locator_ldap_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_LDAP_SERVERS_IN_TABLE}    ${ldap_server}
    ${status}=    run keyword and return status    wait until page contains element    ${locator_ldap_server_in_table}
    [Teardown]    unselect frame
    [return]    ${status}

Delete LDAP Server
    [Arguments]    ${ldap_server}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    ${locator_ldap_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_LDAP_SERVERS_IN_TABLE}    ${ldap_server}
    Wait Until Element Is Visible    ${locator_ldap_server_in_table}
    click element    ${locator_ldap_server_in_table}
    click button    ${USER_LDAP_SERVERS_DELETE_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${USER_LDAP_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    click button    ${USER_LDAP_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    #verify if the user is deleted successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CREATE_NEW}
    Wait Until Page Does Not Contain Element    ${locator_ldap_server_in_table}
    [Teardown]    unselect frame

Edit LDAP Server
    [Arguments]    ${ldap_server_name}     ${attribute}    ${value}
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
    edit ldap server value according to attribute     ${attribute}    ${value}
    click button    ${USER_LDAP_SERVERS_USER_OK}
    #verify if the user is updated successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    [Teardown]    Unselect Frame

edit ldap server value according to attribute
    [Arguments]    ${attribute}    ${value}    ${within_user_wizard}=${False}
    Run keyword if    "${attribute}"=="Name"    set or change ldap name    ${value}
    ...    ELSE IF    "${attribute}"=="Server IP/Name"    set or change ldap server ip    ${value}
    ...    ELSE IF    "${attribute}"=="Server Port"    set or change ldap server port    ${value}
    ...    ELSE IF    "${attribute}"=="Common Name Identifier"    set or change ldap Common Name    ${value}
    ...    ELSE IF    "${attribute}"=="Distinguished Name"    set or change ldap Distinguished Name    ${value}
    ...    ELSE IF    "${attribute}"=="Browse"    query Distinguished Name    ${value}       ${within_user_wizard}
    ...    ELSE IF    "${attribute}"=="Bind Type"    set or change ldap server bind type    ${value}
    ...    ELSE IF    "${attribute}"=="Username"    set or change ldap regular username    ${value}
    ...    ELSE IF    "${attribute}"=="Password"    set or change ldap regular password    ${value}
    ...    ELSE IF    "${attribute}"=="Secure Connection"    set or change ldap server secure connection    ${value}
    ...    ELSE IF    "${attribute}"=="Protocol"    set or change ldap server protocol    ${value}
    ...    ELSE IF    "${attribute}"=="Certificate"    choose or change ldap server certificate    ${value}
    ...    ELSE IF    "${attribute}"=="Test Connectivity"    test ldap server connectivity    ${value}
    ...    ELSE IF    "${attribute}"=="Test User Credentials"    test ldap server user credentials    @{value}    ${within_user_wizard}
    ...    ELSE    Fail    Unknown attribute, it should be exactly same as in GUI page.

set or change ldap name
    [Arguments]    ${ldap_server_name}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_NAME_INPUT}
    input text    ${USER_LDAP_SERVERS_NAME_INPUT}    ${ldap_server_name}

set or change ldap server ip
    [Arguments]    ${ldap_server_ip}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_IP_INPUT}
    input text    ${USER_LDAP_SERVERS_IP_INPUT}    ${ldap_server_ip}

set or change ldap server port
    [Arguments]    ${ldap_server_port}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_PORT_INPUT}
    input text    ${USER_LDAP_SERVERS_PORT_INPUT}    ${ldap_server_port}

set or change ldap Common Name
    [Arguments]    ${ldap_server_cn}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CN_INPUT}
    input text    ${USER_LDAP_SERVERS_CN_INPUT}    ${ldap_server_cn}

set or change ldap Distinguished Name
    [Arguments]    ${ldap_server_dn}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_DN_INPUT}
    input text    ${USER_LDAP_SERVERS_DN_INPUT}    ${ldap_server_dn}

query Distinguished Name
    [Arguments]    ${ldap_server_dn}=${EMPTY}    ${within_user_wizard}=${False}
    ${current_dn}=    Get Element Attribute    ${USER_LDAP_SERVERS_DN_INPUT}    value
    Run keyword if     "${ldap_server_dn}"!="${EMPTY}"    set or change ldap Distinguished Name    ${ldap_server_dn}
    Wait Until Element is Visible    ${USER_LDAP_SERVERS_DN_BROWSE}
    Click Button    ${USER_LDAP_SERVERS_DN_BROWSE}
    ${tree_root_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LDAP_SERVERS_DN_BROWSE_TREE_NODE}    ${current_dn}
    Run keyword if    ${within_user_wizard}    Unselect Frame
    Wait Until Element is Visible    ${tree_root_locator}
    Click Button    ${USER_LDAP_SERVERS_DN_BROWSE_CANCEL}
    Wait Until Element is not Visible    ${tree_root_locator}
    [Teardown]    Run keyword if    ${within_user_wizard}    Select Frame    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}

select Distinguished Name from tree
    [Arguments]    ${ldap_server_dn}
    Wait Until Element is Visible    ${USER_LDAP_SERVERS_DN_BROWSE}
    Click Button    ${USER_LDAP_SERVERS_DN_BROWSE}
    ${dn_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LDAP_SERVERS_DN_BROWSE_TREE_NODE}    ${ldap_server_dn}
    Wait Until Element is Visible    ${dn_locator}
    Click element    ${dn_locator}
    Click Button    ${USER_LDAP_SERVERS_DN_BROWSE_OK}
    Wait Until Element is not Visible    ${dn_locator}
    ${current_dn}=    Get Element Attribute    ${USER_LDAP_SERVERS_DN_INPUT}    value
    Should be equal    ${current_dn}    ${dn_locator}

set or change ldap server bind type
    [Arguments]    ${type}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LDAP_SERVERS_BIND_TYPE}    ${type}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

set or change ldap regular username
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_USERNAME_INPUT}
    input text    ${USER_LDAP_SERVERS_USERNAME_INPUT}    ${username}

set or change ldap regular password
    [Arguments]    ${password}
    ${is_change_button_exists}=    Run keyword and return status    Element Should Be Visible    ${USER_LDAP_SERVERS_PASSWORD_CHANGE_BUTTON}
    Run keyword if    ${is_change_button_exists}    Click Button    ${USER_LDAP_SERVERS_PASSWORD_CHANGE_BUTTON}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_PASSWORD}
    input text    ${USER_LDAP_SERVERS_PASSWORD}    ${password}

set or change ldap server secure connection
    [Arguments]    ${if_enabled}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_SECURE_LABEL}
    ${if_already_enabled}=    Run keyword and return status    Checkbox Should Be Selected    {USER_LDAP_SERVERS_SECURE_CHECKBOX}
    Run keyword if    ${if_enabled} is not ${if_already_enabled}    Click Element    ${USER_LDAP_SERVERS_SECURE_LABEL}

set or change ldap server protocol
    [Arguments]    ${type}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LDAP_SERVERS_PROTOCOL}    ${type}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

choose or change ldap server certificate
    [Arguments]    ${certificate_name}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CERTIFICATE_DIV}
    Click Element    ${USER_LDAP_SERVERS_CERTIFICATE_DIV}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LDAP_SERVERS_CERTIFICATE_DIV_IN_DROPDOWN}    ${certificate_name}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}
    Wait Until Element Is Visible    ${VAR_USER_LDAP_SERVERS_CERTIFICATE_DIV_SELECTED}

test ldap server connectivity
    [Arguments]    ${expected_status}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CONNECTIVITY_BUTTON}
    Click Button    ${USER_LDAP_SERVERS_TEST_CONNECTIVITY_BUTTON}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_CONNECTION_STATUS}
    ${status}=    Get Text    ${USER_LDAP_SERVERS_CONNECTION_STATUS}
    Should Contain    ${status}    ${expected_status}

test ldap server user credentials
    [Arguments]    ${username}    ${password}    ${expected_result}    ${within_user_wizard}=${False}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_BUTTON}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_BUTTON}
    Run keyword if    ${within_user_wizard}    Unselect Frame
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_HEAD}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    
    Input Text    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    ${username}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    
    Input Text    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    ${password}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_TEST_BUTTON}
    Wait Until Element Is Visible     ${USER_LDAP_SERVERS_CREDENTIALS_STATUS}
    ${status}=    Get Text    ${USER_LDAP_SERVERS_CREDENTIALS_STATUS}
    Should Contain    ${status}    ${expected_result}
    Click Button    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_CLOSE_BUTTON}
    Wait Until Element is not Visible    ${USER_LDAP_SERVERS_TEST_CREDENTIALS_HEAD}
    [Teardown]    Run keyword if    ${within_user_wizard}    Select Frame    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}
