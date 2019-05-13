*** Settings ***
Documentation      To verify the multiple vdoms can be disabled even they are not empty from GUI
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom_list}     ${SYSTEM_TEST_VDOM_NAME_2}    

*** Test Cases ***
181544

    [Tags]    v6.0    chrome   181544    Critical    win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go to system
    sleep  2
    go to system_VDOM
    select frame     ${NETWORK_FRAME}
    :FOR  ${element}    IN    @{vdom_list}
    \   SET VDOM DISABLE   ${element}
    \   ${vdom}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY_DISABLED}    ${element}
    \   ${status}=  get element attribute   ${vdom}${SYSTEM_VDOM_TABLE_ENTRY_ENABLE_COLUMN}   title
    \   should be equal     "${status}"    "No"
    \   sleep   2
    \   SET VDOM ENABLE   ${element}
    \   ${vdom}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}   ${element}
    \   ${status}=  get element attribute   ${vdom}${SYSTEM_VDOM_TABLE_ENTRY_ENABLE_COLUMN}   title
    \   should be equal     "${status}"    "Yes"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

