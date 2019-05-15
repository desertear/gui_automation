*** Settings ***
Documentation     This file contains FortiGate GUI User and Device->User Groups operation

*** Keywords ***
###User & Device###
##User & Device ->User Groups##
Go to User Groups
    Wait Until Element Is Visible    ${USER_GROUP_ENTRY}
    click element    ${USER_GROUP_ENTRY}

Create new group
    [Arguments]    ${group_type}     ${groupname}    ${members}=@{EMPTY}    ${remote_groups}=@{EMPTY}
    #members and remote_groups must be assigned with list
    # user_type:  firewall, fsso, rsso, and guest
    Go to User and Device
    Go to User Groups
    ${status}=    If group exists    ${groupname}
    run keyword if    "${status}"=="${True}"     Delete Group    ${groupname}
    Wait Until Element Is Visible    ${GROUP_CREATE_NEW_BUTTON}
    click button    ${GROUP_CREATE_NEW_BUTTON}
    Wait Until Element Is Visible    ${GROUP_WIZARD_H1}
    input text    ${GROUP_NAME_TEXT}    ${groupname}
    choose group type   ${group_type}
    Add users to Group    @{members}
    add remote groups to user group    @{remote_groups}
    click button    ${GROUP_OK_BUTTON}
    #verify if the group is created successfully
    group should exist    ${groupname}

choose group type
    [Arguments]    ${group_type}=firewall
    # user_type:  firewall, fsso, rsso, and guest
    &{text_type_mapping}=    Create Dictionary    firewall=Firewall    fsso=Fortinet Single Sign-On (FSSO)
    ...    rsso=RADIUS Single Sign-On (RSSO)    guest=Guest
    ${label_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_TYPE_FIREWALL_LABEL}    &{text_type_mapping}[${group_type}]
    Wait Until Element Is Visible    ${label_locator}
    Click Element    ${label_locator}

add remote groups to user group
    [Arguments]    @{mutiple_dic_data}
    :FOR    ${dic_data}    IN    @{mutiple_dic_data}
    \     add remote group to user group    &{dic_data}

add remote group to user group
    [Arguments]    &{dic_data}
    [Documentation]    key of &{dic_data} contains server_type, server_name, and remote_groups
    ...    server_type can be ldap, radius, and tacacs
    ${server_type}=   Get From Dictionary    ${dic_data}     server_type
    ${server_name}=   Get From Dictionary    ${dic_data}     server_name
    @{remote_groups}=   Get From Dictionary    ${dic_data}     remote_groups
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_ADD_BUTTON}
    Click Button    ${GROUP_REMOTE_GROUPS_ADD_BUTTON}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_HEAD}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_DROPDOWN_DIV}
    Click Element    ${GROUP_REMOTE_GROUPS_DROPDOWN_DIV}
    ${server_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_GROUP_IN_DROPDOWN}    ${server_name}
    Wait Until Element Is Visible    ${server_locator}
    Click Element    ${server_locator}
    ${server_selected_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_GROUP_SELECTED}    ${server_name}
    Wait Until Element Is Visible    ${server_selected_locator}
    match remote groups to user group    ${server_type}    @{remote_groups}
    confirm remote group is added    ${server_name}

delete remote group from user group
    [Arguments]    ${server_name}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_ADD_BUTTON}
    confirm remote group is added    ${server_name}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_ENTRY_IN_TABLE}    ${server_name}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_DELETE_BUTTON}
    Click Element    ${GROUP_REMOTE_GROUPS_DELETE_BUTTON}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_SERVER_DELETE_HEAD}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_SERVER_DELETE_HEAD}
    Click Button    ${GROUP_REMOTE_GROUPS_SERVER_DELETE_OK_BUTTON}
    confirm remote group is deleted    ${server_name}

edit ldap remote group for user group
    [Arguments]    &{dic_data}
    [Documentation]    key of &{dic_data} contains server_name, original_remote_groups, and remote_groups
    ${server_name}=   Get From Dictionary    ${dic_data}     server_name
    @{original_remote_groups}=   Get From Dictionary    ${dic_data}     original_remote_groups
    @{remote_groups}=   Get From Dictionary    ${dic_data}     remote_groups
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_ADD_BUTTON}
    confirm remote group is added    ${server_name}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_ENTRY_IN_TABLE}    ${server_name}
    Wait Until Element Is Visible    ${locator}
    Click element    ${locator}
    Wait Until Element Is Visible    ${GROUP_REMOTE_GROUPS_EDIT_BUTTON}
    Click Element    ${GROUP_REMOTE_GROUPS_EDIT_BUTTON}
    remove ldap groups from user group    @{original_remote_groups}
    add ldap groups to user group    @{remote_groups}
    click button    ${GROUP_REMOTE_GROUPS_SERVER_BROWSER_OK_BUTTON}
    confirm remote group is added    ${server_name}

match remote groups to user group
    [Arguments]    ${server_type}    @{remote_groups}
    Run keyword if    "${server_type}"=="ldap"    match ldap groups to user group    @{remote_groups}
    ...    ELSE IF     "${server_type}"=="radius"    specify radius or tacacs groups    @{remote_groups}
    ...    ELSE IF     "${server_type}"=="tacacs"    specify radius or tacacs groups    @{remote_groups}
    ...    ELSE    Fail Unknown remote group type: ${server_type}

match ldap groups to user group
    [Arguments]    @{remote_groups}
    add ldap groups to user group    @{remote_groups}
    click button    ${GROUP_REMOTE_GROUPS_SERVER_BROWSER_OK_BUTTON}

add ldap groups to user group
    [Arguments]    @{remote_groups}
    Wait Until Element is Visible    ${GROUP_REMOTE_GROUPS_SERVER_BROWSER}
    :FOR    ${group}    IN    @{remote_groups}
    \    ${group_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_SERVER_IN_LIST}    ${group}
    \    Wait Until Element is Visible    ${group_locator}
    \    Open Context Menu    ${group_locator}
    \    Wait Until Element is Visible    ${GROUP_REMOTE_GROUPS_SERVER_ADD_BUTTON}
    \    Click Button    ${GROUP_REMOTE_GROUPS_SERVER_ADD_BUTTON}

remove ldap groups from user group
    [Arguments]    @{remote_groups}
    Wait Until Element is Visible    ${GROUP_REMOTE_GROUPS_SERVER_BROWSER}
    :FOR    ${group}    IN    @{remote_groups}
    \    ${group_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_SERVER_IN_LIST}    ${group}
    \    Wait Until Element is Visible    ${group_locator}
    \    Open Context Menu    ${group_locator}
    \    Wait Until Element is Visible    ${GROUP_REMOTE_GROUPS_SERVER_REMOVE_BUTTON}
    \    Click Button    ${GROUP_REMOTE_GROUPS_SERVER_REMOVE_BUTTON}

match radius or tacacs plus groups to user group
    [Arguments]    @{remote_groups}
    ${length}=    Get Length    ${remote_groups}
    Run keyword if    ${length}==${1} and "@{remote_groups}[0]"=="any"    Click Element    ${GROUP_REMOTE_GROUPS_GROUP_LABEL_ANY}
    ...    ELSE    specify radius or tacacs groups    @{remote_groups}

specify radius or tacacs groups
    [Arguments]    @{remote_groups}
    # Click Element    ${GROUP_REMOTE_GROUPS_GROUP_LABEL_SPECIFY}
    Log    To do later

confirm remote group is added
    [Arguments]    ${server_name}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_ENTRY_IN_TABLE}    ${server_name}
    Wait Until Element Is Visible    ${locator}

confirm remote group is deleted
    [Arguments]    ${server_name}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_REMOTE_GROUPS_ENTRY_IN_TABLE}    ${server_name}
    Wait Until Element Is Not Visible    ${locator}

group should exist
    [Arguments]    ${groupname}
    ${status}=    If group exists    ${groupname}
    Should be True    ${status}

If group exists
    [Arguments]    ${groupname}
    Wait Until Element Is Visible    ${GROUP_LIST_COLUMN}
    ${locator_group_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_GROUP_IN_TABLE}    ${groupname} 
    ${status}=    run keyword and return status    wait until page contains element    ${locator_group_in_table}
    [return]    ${status}

Delete Group
    [Arguments]    ${groupname}
    ${locator_group_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_GROUP_IN_TABLE}    ${groupname} 
    Wait Until Element Is Visible    ${locator_group_in_table}
    click element    ${locator_group_in_table}
    click button    ${GROUP_DELETE_GROUP_BUTTON}
    Wait Until Element Is Visible    ${GROUP_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${GROUP_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${GROUP_DELETE_CONFIRM_OK_BUTTON}
    click button    ${GROUP_DELETE_CONFIRM_OK_BUTTON}
    #verify if the Group is deleted successfully
    Wait Until Element Is Visible    ${GROUP_LIST_COLUMN}
    Wait Until Page Does Not Contain Element    ${locator_group_in_table}

Add users to Group
    [Arguments]    @{members}
    Wait Until Element Is Visible    ${GROUP_MEMBERS_DIV}
    click element    ${GROUP_MEMBERS_DIV}
    Wait Until Element Is Visible    ${GROUP_SELECT_ENTRY_LIST}
    :FOR    ${member}    IN    @{members}
    \    Add user to Group    ${member}
    click button    ${GROUP_SELECT_ENTRY_CLOSE_BUTTON}

Add user to Group
    [Arguments]    ${member}
    ${locator_user_in_list}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_SELECT_ENTRY_USE_IN_LIST}    ${member}
    Wait Until Element Is Visible    ${locator_user_in_list}
    click element    ${locator_user_in_list}
    ${locator_user_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_GROUP_SELECT_ENTRY_USE_IN_DIV}    ${member}
    Wait Until Element Is Visible    ${locator_user_in_div}    

