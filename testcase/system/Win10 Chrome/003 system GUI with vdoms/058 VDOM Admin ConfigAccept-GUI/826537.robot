*** Settings ***
Documentation      GUI:Verify can create VDOM name with a maximum length of 31 characters on GUI after long-vdom-name is enabled
Resource    ../../../system_resource.robot

*** Variables ***
${vdom_name_32}   1234567890123456789012345_Long32
${vdom_name_31}   123456789012345678901234_Long31
*** Test Cases ***
826537
##
    [Tags]    v6.0    chrome   826537    high    win10,64bit    browsers    runable   
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go to system
    sleep  2
    go to system_VDOM
    select frame        ${NETWORK_FRAME}
    wait and click      ${SYSTEM_VDOM_CREATE NEW_BUTTON}
    sleep   2
    wait and click      ${SYSTEM_VDOM_NEW_VDOM_NAME}
    clear element text  ${SYSTEM_VDOM_NEW_VDOM_NAME}
    ## test long-name 32 cannot be input ###
    input text          ${SYSTEM_VDOM_NEW_VDOM_NAME}    ${vdom_name_32}
    wait and click      ${SUBMIT_OK_SPAN}
    sleep  2
    Wait Until Element Is Visible    ${SYSTEM_VDOM_NEW_VDOM_NAME_WARN}
    clear element text  ${SYSTEM_VDOM_NEW_VDOM_NAME}
    ## input long-name 31 ###
    input text          ${SYSTEM_VDOM_NEW_VDOM_NAME}    ${vdom_name_31}
    wait and click      ${SUBMIT_OK_SPAN}
    ## double check if the vdom if created and delete it ###
    sleep   2
    unselect frame
    Go to system
    go to system_VDOM
    select frame      ${NETWORK_FRAME}
    ${vdom}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}    ${vdom_name_31}
    wait and click    ${vdom}
    wait and click    ${SYSTEM_VDOM_DELETE_BUTTON}
    unselect frame
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep   2
    unselect frame
    select frame      ${NETWORK_FRAME}
    ## double check the vdom is deleted  ###
    ${vdom}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}    ${vdom_name_31}
    ${status}=    run keyword and return status    wait until element is visible    ${vdom}
    should be equal    "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

