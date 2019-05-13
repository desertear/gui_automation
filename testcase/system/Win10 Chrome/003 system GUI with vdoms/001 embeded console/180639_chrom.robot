*** Settings ***
Documentation    Verify that changing  the  color scheme  like  text and background is working
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
180639
    [Documentation]    
    [Tags]    v6.0    chrome   180639    critical    win10,64bit    browsers  norun   keyboard
    
        
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
    