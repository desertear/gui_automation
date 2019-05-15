*** Settings ***
Documentation     This file contains all operations on User->TACACS+ Servers

*** Keywords ***
###User & Device###
##User & Device ->TACACS Servers##
Go to TACACS Servers
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_ENTRY}
    click element    ${USER_TACACS_SERVERS_ENTRY}

Create New TACACS Server
    [Arguments]    ${tacacs_server_name}     ${auth_method}
    ...    ${primary_ip}    ${primary_secret}
    ...    ${seconary_ip}=${EMPTY}    ${secondary_secret}=${EMPTY}
    ...    ${tertiary_ip}=${EMPTY}    ${tertiary_secret}=${EMPTY}
    Go to User and Device
    Go to TACACS Servers
    ${status}=    If TACACS Server exists    ${tacacs_server_name}
    run keyword if    "${status}"=="True"     Delete TACACS Server    ${tacacs_server_name}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_CREATE_NEW}
    click button    ${USER_TACACS_SERVERS_CREATE_NEW}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_NEW_H1}
    set Tacacs name    ${tacacs_server_name}
    set Tacacs Authentication method    ${auth_method}
    set Tacacs primary server ip    ${primary_ip}
    set Tacacs primary server secret    ${primary_secret}
    set Tacacs Secondary server ip    ${seconary_ip}
    set Tacacs Secondary server secret    ${secondary_secret}
    set Tacacs tertiary server ip    ${tertiary_ip}
    set Tacacs tertiary server secret    ${tertiary_secret}
    Click Button    ${USER_TACACS_SERVERS_USER_OK}
    TACACS Server Should exist    ${tacacs_server_name}

set Tacacs name
    [Arguments]    ${tacacs_server_name}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_NAME_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_NAME_INPUT}    ${tacacs_server_name}

set Tacacs Authentication method
    [Arguments]    ${auth_method}
    ${locator_auth_tab}=    Run keyword if    "${auth_method}"=="Auto"    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_TACACS_SERVERS_AUTH_METHOD_TAB}    ${auth_method}
    ...    ELSE    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_TACACS_SERVERS_AUTH_METHOD_TAB}    Specify
    Click Element    ${locator_auth_tab}
    Run keyword if    "${auth_method}"!="Auto"    specify Tacacs Authentication method    ${auth_method}

specify Tacacs Authentication method
    [Arguments]    ${auth_method}
    Wait Until Element Is visible    ${USER_TACACS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}
    Click element    ${USER_TACACS_SERVERS_AUTH_METHOD_DROPDOWN_DIV}
    ${locator_method_in_dropdown}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_TACACS_SERVERS_AUTH_METHOD_IN_DROPDOWN}    ${auth_method}
    wait until page contains element    ${locator_method_in_dropdown}
    Click Element    ${locator_method_in_dropdown}
    ${locator_method_in_div}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_USER_TACACS_SERVERS_AUTH_METHOD_IN_DIV}    ${auth_method}
    wait until page contains element    ${locator_method_in_div}

set Tacacs primary server ip
    [Arguments]    ${primary_ip}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_PRIMARY_IP_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_PRIMARY_IP_INPUT}    ${primary_ip}    

set Tacacs primary server secret
    [Arguments]    ${primary_secret}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_PRIMARY_SECRET_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_PRIMARY_SECRET_INPUT}    ${primary_secret}  

set Tacacs Secondary server ip
    [Arguments]    ${seconary_ip}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_SECONDARY_IP_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_SECONDARY_IP_INPUT}    ${seconary_ip} 

set Tacacs Secondary server secret
    [Arguments]    ${secondary_secret}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_SECONDARY_SECRET_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_SECONDARY_SECRET_INPUT}    ${secondary_secret}  

set Tacacs tertiary server ip
    [Arguments]    ${tertiary_ip}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_TERTIARY_IP_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_TERTIARY_IP_INPUT}    ${tertiary_ip} 

set Tacacs tertiary server secret
    [Arguments]    ${tertiary_secret}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_TERTIARY_SECRET_INPUT}    
    Input Text    ${USER_TACACS_SERVERS_TERTIARY_SECRET_INPUT}    ${tertiary_secret} 

If TACACS Server exists
    [Arguments]    ${tacacs_server}
    ${status}=    run keyword and return status    TACACS Server Should exist    ${tacacs_server}
    [return]    ${status}

TACACS Server Should exist
    [Arguments]    ${tacacs_server}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_CREATE_NEW}
    ${locator_tacacs_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_TACACS_SERVERS_IN_TABLE}    ${tacacs_server}
    Wait Until Element Is Visible    ${locator_tacacs_server_in_table}

Delete TACACS Server
    [Arguments]    ${tacacs_server}
    ${locator_tacacs_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_TACACS_SERVERS_IN_TABLE}    ${tacacs_server}
    Wait Until Element Is Visible    ${locator_tacacs_server_in_table}
    click element    ${locator_tacacs_server_in_table}
    click button    ${USER_TACACS_SERVERS_DELETE_BUTTON}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_DELETE_CONFIRM_HEAD}
    Wait Until page contains Element    ${USER_TACACS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    click button    ${USER_TACACS_SERVERS_DELETE_CONFIRM_OK_BUTTON}
    #verify if the user is deleted successfully
    ${locator_tacacs_server_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_TACACS_SERVERS_IN_TABLE}    ${tacacs_server}
    Wait Until Element Is Not Visible    ${locator_tacacs_server_in_table}

Edit Tacacs Server
    [Arguments]    ${tacacs_server_name}     ${attribute}    ${value}
    Go to User and Device
    Go to Tacacs Servers
    ${status}=    If Tacacs Server exists    ${tacacs_server_name}
    Should be True    ${status}
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_TACACS_SERVERS_IN_TABLE}    ${tacacs_server_name}
    click element    ${locator}
    Click button    ${USER_TACACS_SERVERS_EDIT_BUTTON}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_EDIT_H1}
    edit tacacs server value according to attribute     ${attribute}    ${value}
    click button    ${USER_TACACS_SERVERS_USER_OK}
    #verify if the user is updated successfully
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_CREATE_NEW}

edit tacacs server value according to attribute
    [Arguments]    ${attribute}    ${value}
    Run keyword if    "${attribute}"=="Test"    test primary TACACS server connectivity    ${value}
    ...    ELSE    Fail    Unknown attribute, it should be exactly same as in GUI page.

test primary TACACS server connectivity
    [Arguments]    ${expected_status}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}
    Click Button    ${USER_TACACS_SERVERS_PRIMARY_TEST_CONNECTIVITY_BUTTON}
    Wait Until Element Is Visible    ${USER_TACACS_SERVERS_PRIMARY_CONNECTION_STATUS}
    ${status}=    Get Text when it is not empty    ${USER_TACACS_SERVERS_PRIMARY_CONNECTION_STATUS}
    Should Contain    ${status}    ${expected_status}
