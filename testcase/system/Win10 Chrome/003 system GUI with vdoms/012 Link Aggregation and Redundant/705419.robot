*** Settings ***
Documentation    [GUI] Verify the redundant interface can be created and deleted in CLI and GUI in TP mode
Resource    ../../../system_resource.robot

*** Variables ***
@{interface}    ${SYSTEM_TEST_INTF_3}    ${SYSTEM_TEST_INTF_4}
*** Test Cases ***
705419
    [Tags]    v6.0    chrome   705419    Critical    win10,64bit    browsers    system   runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate   
    sleep   2
    Go to VDOM     ${SYSTEM_TEST_VDOM_NAME_TP}
    Go to network
    Go to network_Interfaces
    Create Network Interface   705419    type=Redundant  physical_interface=${interface}   vdom_mode_tp=yes
    network delete interface   705419    table_type=Redun
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
   write test result to file    ${CURDIR}


