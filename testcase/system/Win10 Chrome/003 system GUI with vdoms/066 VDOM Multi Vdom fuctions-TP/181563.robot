*** Settings ***
Documentation    To verify interfaces are displayed per virtual domain in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
*** Test Cases ***
181563
    [Tags]    v6.0    chrome   181563   High     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}   
    Go to network
    Go to network_Interfaces
    ${num_vdomtp}=   COUNT INTERFACES OF VDOM   ${SYSTEM_TEST_VDOM_NAME_TP}
    should be true  "${num_vdomtp}"=="1"
    unselect frame
    ${num_vdom1}=    COUNT INTERFACES OF VDOM   ${SYSTEM_TEST_VDOM_NAME_1}
    should be true  "${num_vdom1}"=="0"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

