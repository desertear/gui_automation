*** Settings ***
Documentation     This file contains all operations on User->RADIUS Servers

*** Keywords ***
###User & Device###
##User & Device ->RADIUS Servers##
Go to RADIUS Servers
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_ENTRY}
    click element    ${USER_RADIUS_SERVERS_ENTRY}


Create New RADIUS Server
    [Arguments]    ${radius_server_name}     ${auth_method}    ${nas_ip}    ${all_usergroup}
    ...    ${primary_ip}    ${primary_secret}    ${seconary_ip}=${EMPTY}    ${secondary_secret}=${EMPTY}
    Go to User and Device
    Go to RADIUS Servers
    ${status}=    If RADIUS Server exists    ${radius_server_name}
    run keyword if    "${status}"=="True"     Delete RADIUS Server    ${radius_server_name}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_CREATE_NEW}
    click button    ${USER_RADIUS_SERVERS_CREATE_NEW}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_NEW_H1}
    set Radius name    ${radius_server_name}
    set Radius Authentication method    ${auth_method}
    set Radius NAS IP    ${nas_ip}
    include in every user group for Radius    ${all_usergroup}
    set Radius primary server ip    ${primary_ip}
    set Radius primary server secret    ${primary_secret}
    set Radius Secondary server ip    ${seconary_ip}
    set Radius Secondary server secret    ${secondary_secret}
    Click Button    ${USER_RADIUS_SERVERS_USER_OK}
    RADIUS Server Should exist    ${radius_server_name}

set Radius name
    [Arguments]    ${radius_server_name}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_NAME_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_NAME_INPUT}    ${radius_server_name}

set Radius Authentication method
    [Arguments]    ${auth_method}
    ${locator_auth_tab}=    Run keyword if    "${auth_method}"=="Default"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_TAB}    ${auth_method}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_TAB}    Specify
    Click Element    ${locator_auth_tab}
    Run keyword if    "${auth_method}"!="Default"    specify Radius Authentication method    ${auth_method}

specify Radius Authentication method
    [Arguments]    ${auth_method}
    Wait Until Element Is visible    ${USER_RADIUS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}
    Click element    ${USER_RADIUS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}
    ${locator_method_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_IN_DROPDOWN}    ${auth_method}
    wait until page contains element    ${locator_method_in_dropdown}
    Click Element    ${locator_method_in_dropdown}
    ${locator_method_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_RADIUS_SERVERS_AUTH_METHOD_IN_DIV}    ${auth_method}
    wait until page contains element    ${locator_method_in_div}

set Radius NAS IP
    [Arguments]    ${nas_ip}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_NAS_IP_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_NAS_IP_INPUT}    ${nas_ip}

include in every user group for Radius
    [Arguments]    ${all_usergroup}
    Wait Until page Contains element    ${USER_RADIUS_SERVERS_USER_GROUP_CHECKBOX}
    Wait Until Element is Visible    ${USER_RADIUS_SERVERS_USER_GROUP_LABEL}
    ${if_selected}=    Run keyword and return status    Checkbox Should Be Selected    ${USER_RADIUS_SERVERS_USER_GROUP_CHECKBOX}
    Run keyword if    ${all_usergroup} is not ${if_selected}    Click Element    ${USER_RADIUS_SERVERS_USER_GROUP_LABEL}

set Radius primary server ip
    [Arguments]    ${primary_ip}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_PRIMARY_IP_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_PRIMARY_IP_INPUT}    ${primary_ip}    

set Radius primary server secret
    [Arguments]    ${primary_secret}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_PRIMARY_SECRET_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_PRIMARY_SECRET_INPUT}    ${primary_secret}  

set Radius Secondary server ip
    [Arguments]    ${seconary_ip}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_SECONDARY_IP_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_SECONDARY_IP_INPUT}    ${seconary_ip} 

set Radius Secondary server secret
    [Arguments]    ${secondary_secret}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_SECONDARY_SECRET_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_SECONDARY_SECRET_INPUT}    ${secondary_secret}  

If RADIUS Server exists
    [Arguments]    ${radius_server}
    ${status}=    run keyword and return status    RADIUS Server Should exist    ${radius_server}
    [return]    ${status}

RADIUS Server Should exist
    [Arguments]    ${radius_server}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_CREATE_NEW}
    ${locator_radius_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_RADIUS_SERVERS_IN_TABLE}    ${radius_server}
    Wait Until Element Is Visible    ${locator_radius_server_in_table}

Delete RADIUS Server
    [Arguments]    ${radius_server}
    ${locator_radius_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_RADIUS_SERVERS_IN_TABLE}    ${radius_server}
    Wait Until Element Is Visible    ${locator_radius_server_in_table}
    click element    ${locator_radius_server_in_table}
    click button    ${USER_RADIUS_SERVERS_DELETE_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${USER_RADIUS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    click button    ${USER_RADIUS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    #verify if the user is deleted successfully
    ${locator_radius_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_RADIUS_SERVERS_IN_TABLE}    ${radius_server}
    Wait Until Element Is Not Visible    ${locator_radius_server_in_table}

Edit Radius Server
    [Arguments]    ${radius_server_name}     ${attribute}    ${value}
    Go to User and Device
    Go to Radius Servers
    ${status}=    If Radius Server exists    ${radius_server_name}
    Should be True    ${status}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_RADIUS_SERVERS_IN_TABLE}    ${radius_server_name}
    click element    ${locator}
    Click button    ${USER_RADIUS_SERVERS_EDIT_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_EDIT_H1}
    edit radius server value according to attribute     ${attribute}    ${value}
    click button    ${USER_RADIUS_SERVERS_USER_OK}
    #verify if the user is updated successfully
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_CREATE_NEW}

edit radius server value according to attribute
    [Arguments]    ${attribute}    ${value}
    Run keyword if    "${attribute}"=="Test Connectivity"    test primary RADIUS server connectivity    ${value}
    ...    ELSE IF    "${attribute}"=="Test User Credentials"    test primary RADIUS server user credentials    @{value}
    ...    ELSE    Fail    Unknown attribute, it should be exactly same as in GUI page.

test primary RADIUS server connectivity
    [Arguments]    ${expected_status}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}
    Click Button    ${USER_RADIUS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_PRIMARY_CONNECTION_STATUS}
    ${status}=    Get Text when it is not empty    ${USER_RADIUS_SERVERS_PRIMARY_CONNECTION_STATUS}
    Should Contain    ${status}    ${expected_status}

test primary RADIUS server user credentials
    [Arguments]    ${username}    ${password}    ${expected_result}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_PRIMARY_TEST_CREDENTIALS_BUTTON}
    Click Button    ${USER_RADIUS_SERVERS_PRIMARY_TEST_CREDENTIALS_BUTTON}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_HEAD}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_USERNAME_INPUT}    ${username}
    Wait Until Element Is Visible    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    
    Input Text    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_PASSWORD_INPUT}    ${password}
    Click Button    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_TEST_BUTTON}
    Wait Until Element Is Visible     ${USER_RADIUS_SERVERS_CREDENTIALS_STATUS}
    ${status}=    Get Text when it is not empty    ${USER_RADIUS_SERVERS_CREDENTIALS_STATUS}
    Should Contain    ${status}    ${expected_result}
    Wait Until Element Is Visible     ${USER_RADIUS_SERVERS_SERVER_MESSAGE}
    ${server_message}=    Get Text when it is not empty    ${USER_RADIUS_SERVERS_SERVER_MESSAGE}   
    Click Button    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_CLOSE_BUTTON}
    Wait Until Element is not Visible    ${USER_RADIUS_SERVERS_TEST_CREDENTIALS_HEAD}
    [Return]    ${server_message}

