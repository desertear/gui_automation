*** Settings ***
Documentation      To verify confirmation msg pops up when switching management vdom from gui
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom_list}     ${SYSTEM_TEST_VDOM_NAME_2}     ${SYSTEM_TEST_VDOM_NAME_TP}
${warning_message}     xpath://div[text()="Are you sure you want to switch management virtual domain to:\${PLACEHOLDER}?"]

*** Test Cases ***
181548
##
    [Tags]    v6.0    chrome   181548    high    win10,64bit    browsers    runable   rest
    Login FortiGate   
    Go to system
    sleep  2
    go to system_VDOM
    select frame  ${NETWORK_FRAME}
    ### select switch management vdom and click cancle  ###
    ${vdom}=        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}   ${SYSTEM_TEST_VDOM_NAME_2}
    wait and click  ${vdom}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_1}
    wait and click  ${current_manage_vdom}
    unselect frame
    ${message}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${warning_message}   ${SYSTEM_TEST_VDOM_NAME_2}
    wait Until Element Is Visible     ${message}
    wait and click  ${CONFIRM_CANCEL_BUTTON}
    select frame    ${NETWORK_FRAME}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_1}
    Wait Until Element Is Visible     ${current_manage_vdom}

    ### select switch management vdom and click OK  ###
    ${vdom}=        REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_VDOM_TABLE_ENTRY}   ${SYSTEM_TEST_VDOM_NAME_2}
    wait and click  ${vdom}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_1}
    wait and click  ${current_manage_vdom}
    unselect frame
    ${message}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${warning_message}   ${SYSTEM_TEST_VDOM_NAME_2}
    wait Until Element Is Visible     ${message}
    wait and click  ${CONFIRM_OK_BUTTON}
    sleep    2
    select frame    ${NETWORK_FRAME}
    ${current_manage_vdom}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_VDOM_TABLE_ENTRY_SWITCH_MANAGEMENT}    ${SYSTEM_TEST_VDOM_NAME_2}
    wait until element is Visible     ${current_manage_vdom}

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

