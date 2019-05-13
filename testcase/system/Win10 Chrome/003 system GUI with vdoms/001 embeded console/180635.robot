*** Settings ***
Documentation    Verify that the embedded console of FGT with vdoms can be connected using chrome 
Resource    ../../../system_resource.robot

*** Variables ***
@{browsers}     chrome     ff    
## some problem for edge
###  edge
*** Test Cases ***
180635
    [Documentation]    
    [Tags]    v6.0    chrome   180635    critical    win10,64bit    browsers  runable    keyboard    env2fail  
    ##only judge if the embeded console can be connected by different browser, if it does, current case must pass.
    :FOR    ${element}    IN    @{browsers}
        \   Login FortiGate    browser=${element}
        \   sleep   3
        \   popup embed console
        \   go to embed console
        \   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${system_embeded_console_connected}   ${FGT_HOSTNAME}
        \   Wait Until Element Is Visible     ${new_locator}
        \   sleep  2
        \   typewrite    ${system_command_get_sys_status}\n
        \   typewrite    \n
        \   Wait Until Element Is Visible    ${system_command_get_sys_status_key1}
        \   Wait Until Element Is Visible    ${system_command_get_sys_status_key2}
        \   Wait Until Element Is Visible    ${system_command_get_sys_status_key3}
        \   typewrite    ${system_command_diag_sys_flash}\n
        \   Wait Until Element Is Visible    ${system_command_get_sys_flash_key1}
        \   #change prompt to root prompt, then config vdom
        \   go_to_global_prompt
        \   test_vdom_in_emb_console
        \   Unselect Frame   
        \   Logout FortiGate
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    write test result to file    ${CURDIR}


test_vdom_in_emb_console
    typewrite    config vdom\n
    typewrite    edit ${SYSTEM_TEST_VDOM_NAME_1}\n
    typewrite    diag ip add list\n
    Wait Until Element Is Visible    ${system_command_get_sys_vdom_key1}
    