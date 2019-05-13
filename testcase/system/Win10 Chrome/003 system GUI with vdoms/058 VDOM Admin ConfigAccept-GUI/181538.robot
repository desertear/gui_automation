*** Settings ***
Documentation      To verify that a virtual domain could be set as the management vdom
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
181538
##
    [Tags]    v6.0    chrome   181538    high    win10,64bit    browsers    runable   rest
    Login FortiGate   
    Go to system
    sleep  2
    go to system_VDOM
    select frame     ${NETWORK_FRAME}
    ${vdom}=         REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}   ${SYSTEM_TEST_VDOM_NAME_2}
    wait and click   ${vdom}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_1}
    wait and click   ${current_manage_vdom}
    unselect frame
    wait and click   ${CONFIRM_OK_BUTTON}
    sleep    2
    select frame     ${NETWORK_FRAME}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_2}
    wait until element is Visible     ${current_manage_vdom}

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

