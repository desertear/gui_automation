*** Settings ***
Documentation     This file contains FortiGate GUI User and Device->User Definition operation

*** Keywords ***
###User & Device###
##User & Device ->User Definition##
Go to User Definition
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY}
    click element    ${USER_DEFINITION_ENTRY}
    
Go to User SAML SSO
    Wait Until Element Is Visible    ${USER_DEVICE_SAML_SSO_ENTRY}
    click element    ${USER_DEVICE_SAML_SSO_ENTRY}

Create new user
    [Documentation]    key of &{data_dic} can be username, password, email, user_groups, sms_country_code,
    ...    sms_phone_number, token, status, radius_server, tacacs_server, ldap_server, ldap_remote_users
    ...    and fsso_agent. All useless value should be assigned with ${EMPTY}
    [Arguments]    ${user_type}=Local User     &{data_dic}
    ${data_dic}=    fill empty value to Dictionary    &{data_dic}
    ${non_ldap_username}=    Get From Dictionary    ${data_dic}    username
    ${ldap_remote_users}=    Get From Dictionary    ${data_dic}    ldap_remote_users
    @{usernames}=    Run keyword if    "${user_type}"=="Remote LDAP User"    Create List    @{ldap_remote_users}
    ...    ELSE    Create List    ${non_ldap_username}
    Go to User and Device
    Go to User Definition
    ${status}=    If users exist    @{usernames}
    run keyword if    ${status}     Delete users    @{usernames}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    click button    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    unselect frame
    choose user type in step one    ${user_type}
    config user in step two    ${user_type}    &{data_dic}
    config user in step three    ${user_type}    &{data_dic}
    config user in step four    ${user_type}    &{data_dic}
    #verify if the user is created successfully
    verify users have been added    @{usernames}
    [teardown]    unselect frame

choose user type in step one
    [Arguments]    ${user_type}
    Wait Until Element Is Visible    ${USER_WIZARD_H1}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_TYPE}    ${user_type}
    click element    ${locator}
    click button    ${USER_NEXT_BUTTON}

config user in step two
    [Arguments]    ${user_type}    &{data_dic}
    Run keyword if    "${user_type}"=="Local User"    config login credentials in step two    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote RADIUS User"    log    to do function
    ...    ELSE IF    "${user_type}"=="Remote TACACS+ User"    log    to do function
    ...    ELSE IF    "${user_type}"=="Remote LDAP User"    config ldap server in step two    &{data_dic}
    ...    ELSE IF    "${user_type}"=="FSSO"    log    to do function
    ...    ELSE    Fail    Unknown User Type: ${user_type}

config login credentials in step two
    [Arguments]    &{data_dic}
    ${username}=    Get From Dictionary    ${data_dic}    username
    ${password}=    Get From Dictionary    ${data_dic}    password
    Wait Until Element Is Visible    ${USER_LOCAL_USERNAME}
    input text    ${USER_LOCAL_USERNAME}    ${username}
    input password    ${USER_LOCAL_PASSWORD}    ${password}
    ${if_confirm_password}=    Run keyword and return status    Wait Until element is visible    ${USER_LOCAL_CONFIRM_PASSWORD}
    Run keyword if    ${if_confirm_password}    input password    ${USER_LOCAL_CONFIRM_PASSWORD}    ${password}
    click button    ${USER_NEXT_BUTTON}

config ldap server in step two
    [Arguments]    &{data_dic}
    ${ldap_server}=    Get From Dictionary    ${data_dic}    ldap_server
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    Click Element    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_IN_DROPDOWN}    ${ldap_server}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}
    ${selected_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_SELECTED}    ${ldap_server}
    Wait Until Element Is Visible    ${selected_locator}
    click button    ${USER_NEXT_BUTTON}

add and select new ldap server in step two
    [Arguments]    ${ldap_server_name}     ${server_ip}    ${server_port}    ${common_name}    ${distinguished_name}
    ...    ${bind_type}=Simple    ${username}=${EMPTY}    ${password}=${EMPTY}
    ...    ${secure_connection}=${False}    ${protocol}=STARTTLS    ${certificate}=${EMPTY}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    Click Element    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_ADD_BUTTON_IN_DROPDOWN}
    Click Element    ${USER_USER_LDAP_SERVER_ADD_BUTTON_IN_DROPDOWN}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_EDIT_H1}
    Select Frame    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}
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
    Unselect Frame
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_IN_DROPDOWN}    ${ldap_server_name}
    Wait Until Element Is Visible    ${locator}    
    Click Element    ${locator}
    ${selected_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_SELECTED}    ${ldap_server_name}
    Wait Until Element Is Visible    ${selected_locator}
    click button    ${USER_NEXT_BUTTON}

edit and add ldap server in step two
    [Arguments]    ${ldap_server_name}     ${attribute}    ${value}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    Click Element    ${USER_USER_LDAP_SERVER_DROPDOWN_DIV}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_EDIT_IN_DROPDOWN}    ${ldap_server_name}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}
    Wait Until Element Is Visible    ${USER_LDAP_SERVERS_EDIT_H1}
    Select Frame    ${USER_USER_LDAP_SERVER_ADD_LDAP_IFRAME}
    edit ldap server value according to attribute    ${attribute}    ${value}     ${True}
    click button    ${USER_LDAP_SERVERS_USER_OK}
    Unselect Frame
    sleep    2s
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_IN_DROPDOWN}    ${ldap_server_name}
    Wait Until Element Is Visible    ${locator}    
    Click Element    ${locator}
    ${selected_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_SELECTED}    ${ldap_server_name}
    Wait Until Element Is Visible    ${selected_locator}
    click button    ${USER_NEXT_BUTTON}    

config user in step three
    [Arguments]    ${user_type}    &{data_dic}
    Run keyword if    "${user_type}"=="Local User"    config contact info in step three    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote RADIUS User"    config contact info in step three    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote TACACS+ User"    config contact info in step three    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote LDAP User"    config remote user in step three    &{data_dic}
    ...    ELSE IF    "${user_type}"=="FSSO"    log    to do function
    ...    ELSE    Fail    Unknown User Type: ${user_type}

config contact info in step three
    [Arguments]    &{data_dic}
    ${email}=    Get From Dictionary    ${data_dic}    email
    ${sms_country_code}=    Get From Dictionary    ${data_dic}    sms_country_code
    ${sms_phone_number}=    Get From Dictionary    ${data_dic}    sms_phone_number
    ${token}=    Get From Dictionary    ${data_dic}    token
    Wait Until Element Is Visible    ${USER_LOCAL_EMAIL}
    run keyword if    "${email}"!=""    input text    ${USER_LOCAL_EMAIL}    ${email}
    click button    ${USER_NEXT_BUTTON}

config remote user in step three
    [Arguments]    &{data_dic}
    ${ldap_remote_users}=    Get From Dictionary    ${data_dic}    ldap_remote_users
    Wait Until Element is Visible    ${USER_USER_LDAP_SERVER_BROWSER}
    :FOR    ${user}    IN    @{ldap_remote_users}
    \    ${user_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${user}
    \    Wait Until Element is Visible    ${user_locator}
    \    Open Context Menu    ${user_locator}
    \    Wait Until Element is Visible    ${USER_USER_LDAP_SERVER_ADD_BUTTON}
    \    Click Button    ${USER_USER_LDAP_SERVER_ADD_BUTTON}
    click button    ${USER_SUBMIT_BUTTON}

Search user in ldap browser
    [Arguments]    ${filter_type}    ${filter}    ${keyword}    ${is_displayed}    @{expected_usernames}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_FILTER_TYPE_LABEL}    ${filter_type}
    Wait Until Element Is Visible    ${locator}
    Click Button    ${locator}
    Run keyword if    "${filter_type}"=="Custom" and "${filter}"!="${EMPTY}"    set ldap user custom filter and apply    ${filter}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_SEARCH_INPUT}
    Input Text    ${USER_USER_LDAP_SERVER_SEARCH_INPUT}    ${keyword}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_SEARCH_BUTTON}    
    Click Button    ${USER_USER_LDAP_SERVER_SEARCH_BUTTON}
    :FOR    ${user}    IN    @{expected_usernames}
    \    ${user_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_USER_LDAP_SERVER_USERS_IN_LIST}    ${user}
    \    Run keyword if    ${is_displayed}    Wait Until Element is Visible    ${user_locator}
    \    ...    ELSE    Wait Until Element is Not Visible    ${user_locator}

set ldap user custom filter and apply
    [Arguments]    ${filter}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_FILTER_INPUT}
    Input Text    ${USER_USER_LDAP_SERVER_FILTER_INPUT}    ${filter}
    Wait Until Element Is Visible    ${USER_USER_LDAP_SERVER_FILTER_BUTTON}    
    Click Button    ${USER_USER_LDAP_SERVER_FILTER_BUTTON}

config user in step four
    [Arguments]    ${user_type}    &{data_dic}
    Run keyword if    "${user_type}"=="Local User"    config extra info in step four    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote RADIUS User"    config extra info in step four    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote TACACS+ User"    config extra info in step four    &{data_dic}
    ...    ELSE IF    "${user_type}"=="Remote LDAP User"    log    Do Nothing
    ...    ELSE IF    "${user_type}"=="FSSO"    log    Do Nothing
    ...    ELSE    Fail    Unknown User Type: ${user_type}

config extra info in step four
    [Arguments]    &{data_dic}
    ${user_groups}=    Get From Dictionary    ${data_dic}    user_groups
    ${status}=    Get From Dictionary    ${data_dic}    status
    ${length}=    Get Length    ${user_groups}
    Wait Until Element Is Visible    ${USER_LOCAL_GROUP_LABEL}
    ##need more work to set account status
    #Todo
    ##need more work to support mutiple groups
    run keyword if    ${length}!=${0}    Add group to user    @{user_groups}[0]
    click button    ${USER_SUBMIT_BUTTON}

fill empty value to Dictionary
    [Arguments]    &{data_dic}
    ${all_keys}=    Create List    username    password
    ...    radius_server    tacacs_server    ldap_server    ldap_remote_users    fsso_agent
    ...    email    sms_phone_number    sms_country_code    token
    ...    user_groups    status
    ${keys}=    Get Dictionary Keys    ${data_dic}
    :FOR    ${key}    IN    @{all_keys}
    \    ${if_exist}=    Run keyword and return status    Dictionary Should Contain Key    ${data_dic}    ${key}
    \    Run keyword if    not ${if_exist}    Set To Dictionary    ${data_dic}    ${key}    ${EMPTY}
    Log Dictionary    ${data_dic}
    [Return]    &{data_dic}

verify users have been added
    [Arguments]    @{usernames}
    #verify if the user is created successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    :FOR    ${username}    IN    @{usernames}
    \    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    \    ${locator_user_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_DEFINITION_USE_IN_TABLE}    ${username}
    \    Wait Until Element Is Visible    ${locator_user_in_table}
    [Teardown]    unselect frame

If users exist
    [Arguments]    @{usernames}
    ${status}=    run keyword and return status    verify users have been added    @{usernames}
    [return]    ${status}

Delete user
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    ${locator_user_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_DEFINITION_USE_IN_TABLE}    ${username}
    Wait Until Element Is Visible    ${locator_user_in_table}
    click element    ${locator_user_in_table}
    click button    ${USER_DELETE_USER_BUTTON}
    unselect frame
    Wait Until Element Is Visible    ${USER_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${USER_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${USER_DELETE_CONFIRM_OK_BUTTON}
    click button    ${USER_DELETE_CONFIRM_OK_BUTTON}
    #verify if the user is deleted successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    Wait Until Page Does Not Contain Element    ${locator_user_in_table}
    [Teardown]    unselect frame

Delete Users
    [Arguments]    @{usernames}
    :FOR    ${username}    IN    @{usernames}
    \    Delete user    ${username}

Add group to user
    [Arguments]    ${groupname}
    click element    ${USER_LOCAL_GROUP_LABEL}
    Wait Until Element Is Visible    ${USER_LOCAL_GROUP_DIV}
    click element    ${USER_LOCAL_GROUP_DIV}
    wait Until element is Visible    ${USER_LOCAL_GROUP_ENTRY_H1}
    ${locator_group_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LOCAL_GROUP_ENTRY_IN_LIST}    ${groupname}     
    wait Until element is Visible    ${locator_group_in_list}
    click element    ${locator_group_in_list}
    click button    ${USER_LOCAL_GROUP_CLOSE_BUTTON}
    ${locator_group_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_LOCAL_GROUP_IN_DIV}    ${groupname}        
    wait Until element is Visible    ${locator_group_in_div}

Add groups to user
    [Arguments]    @{groupnames}
    :FOR    ${groupname}    IN    @{groupnames}
    \    Add group to user    ${groupname}

Edit User
    [Arguments]    ${username}    ${attribute}    ${value}
    Go to User and Device
    Go to User Definition
    ${status}=    If users exist    ${username}
    Should be True    ${status}
    select frame    ${USER_FRAME}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_DEFINITION_USE_IN_TABLE}    ${username}
    click element    ${locator}
    Click button    ${USER_EDIT_USER}
    Wait Until Element Is Visible    ${USER_EDIT_USER_HEAD}
    Run keyword if    "${attribute}"=="Username"    change user name    ${value}
    ...    ELSE IF    "${attribute}"=="User Account Status"    change user account status    ${value}
    ...    ELSE IF    "${attribute}"=="Password"    change user password    ${value}
    ...    ELSE IF    "${attribute}"=="Email Address"    change user email address    ${value}
    ...    ELSE IF    "${attribute}"=="User Group"    change user group    ${value}
    ...    ELSE IF    "${attribute}"=="SMS"    change user sms    ${value}
    ...    ELSE IF    "${attribute}"=="Two-factor Authentication"    change user two factor    ${value}
    ...    ELSE    Fail    Unknown attribute
    click button    ${USER_EDIT_USER_OK}
    #verify if the user is created successfully
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    [Teardown]    Unselect Frame

change user name
    [Arguments]    ${value}
    Wait Until Element Is Visible    ${USER_EDIT_USER_USERNAME_INPUT}
    input text    ${USER_EDIT_USER_USERNAME_INPUT}    ${value}

change user account status
    [Arguments]    ${value}
    Run keyword if    "${value}"=="Enabled"    Click element    ${USER_EDIT_USER_STATUS_ENABLED}
    ...    ELSE IF    "${value}"=="Disabled"    Click element    ${USER_EDIT_USER_STATUS_DISABLED}
    ...    ELSE    Fail    Unknown User Account Status ${value}

change user password
    [Arguments]    ${value}
    Wait Until Element Is Visible    ${USER_EDIT_USER_PASSWORD_INPUT}
    input text    ${USER_EDIT_USER_PASSWORD_INPUT}    ${value}

change user email address
    [Arguments]    ${value}
    Wait Until Element Is Visible    ${USER_EDIT_USER_EMAIL_INPUT}
    input text    ${USER_EDIT_USER_EMAIL_INPUT}    ${value}

change user group
    [Arguments]    ${value}
    log    todo

change user sms
    [Arguments]    ${value}
    log    todo

change user two factor
    [Arguments]    ${value}
    log    todo

Search User with keyword
    [Arguments]    ${keyword}    @{expected_users}
    Go to User and Device
    Go to User Definition
    Wait Until Element Is Visible    ${USER_FRAME}
    select frame    ${USER_FRAME}
    Wait Until Element Is Visible    ${USER_SEARCH_INPUT}
    input text    ${USER_SEARCH_INPUT}    ${keyword}
    click button    ${USER_SEARCH_BUTTON}
    ${length}=    GET LENGTH    ${expected_users}
    Run Keyword And Return If    "${length}"=="0"    Wait Until Element Is Visible    ${USER_SEARCH_NO_MATCH_TD}
    :FOR    ${user}    IN    @{expected_users}
    \    ${status}=    If user exists in search results    ${user}
    \    Should be True    ${status}
    [Teardown]    unselect frame

If user exists in search results
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USER_DEFINITION_ENTRY_CREATE_NEW}
    ${locator_user_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_SEARCH_USER_IN_TABLE}    ${username}
    ${status}=    run keyword and return status    wait until page contains element    ${locator_user_in_table}
    [return]    ${status}