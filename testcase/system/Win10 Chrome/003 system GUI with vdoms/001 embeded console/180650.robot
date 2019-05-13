*** Settings ***
Documentation    Verify that various commands are working in the embedded console ie. diag, exe
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
180650
    [Documentation]    
    [Tags]    v6.0    chrome   180650    low    win10,64bit    browsers   runable    keyboard   env2fail
    ##only judge if the embeded console can be connected by different browser, if it does, current case must pass.
    Login FortiGate    
    sleep   3
    popup embed console
    go to embed console
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_embeded_console_connected}   ${FGT_HOSTNAME}
    Wait Until Element Is Visible     ${new_locator}
    sleep  2
    typewrite    ${system_command_get_sys_status}\n
    typewrite    \n
    Wait Until Element Is Visible    ${system_command_get_sys_status_key1}
    Wait Until Element Is Visible    ${system_command_get_sys_status_key2}
    Wait Until Element Is Visible    ${system_command_get_sys_status_key3}
    typewrite    ${system_command_diag_sys_flash}\n
    Wait Until Element Is Visible    ${system_command_get_sys_flash_key1}
    #change prompt to root prompt, then config vdom
    go_to_global_prompt
    test_vdom_in_emb_console
    Unselect Frame   
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


test_vdom_in_emb_console
    typewrite    config vdom\n
    typewrite    edit ${SYSTEM_TEST_VDOM_NAME_1}\n
    typewrite    diag ip add list\n
    Wait Until Element Is Visible    ${system_command_get_sys_vdom_key1}
    typewrite    exec ping 8.8.8.8\n
    Wait Until Element Is Visible    ${NETWORK_DNS_DNS_PING_TEST_RETURN}