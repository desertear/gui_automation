*** Settings ***
Documentation      To verify the management vdom can not be disabled from GUI
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
181545
##
    [Tags]    v6.0    chrome   181545    high    win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go to system
    sleep  2
    go to system_VDOM
    select frame     ${NETWORK_FRAME}
    ${vdom}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}    ${SYSTEM_TEST_VDOM_NAME_1}
    wait until element is visible    ${vdom}
    OPEN CONTEXT MENU   ${vdom}
    ${status}=  run keyword and return status   wait and click    ${SYSTEM_VDOM_TABLE_ENTRY_DISABLE_BUTTON}
    should be equal    "${status}"    "False"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

