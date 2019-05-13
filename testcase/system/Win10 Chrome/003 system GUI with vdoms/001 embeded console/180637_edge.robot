*** Settings ***
Documentation    Verify that the embedded console of FGT with vdoms can be connected using chrome 
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
180637
    [Documentation]    
    [Tags]    v6.0    edge   180637    critical    win10,64bit    browsers   norun   keyboard
    ##only judge if the embeded console can be connected by different browser, if it does, current case must pass.
    Login FortiGate    browser=edge
    sleep   3
    popup embed console
    go to embed console
    Wait Until Element Is Visible     ${system_embeded_console_connected}
    typewrite    ${system_command_get_sys_status}\n
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
    