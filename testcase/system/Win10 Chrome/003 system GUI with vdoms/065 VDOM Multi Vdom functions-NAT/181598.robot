*** Settings ***
Documentation    To verify in NAT mode, VLAN interface could be created and deleted in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_interface}    ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
181598
    [Tags]    v6.0    chrome   181598   Critical     win10,64bit    browsers    runable   
    Login FortiGate     
    sleep   2
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}   
    sleep   2
    Go to network
    Go to network_Interfaces
    Create Network Interface    181598  VLAN  ${phy_interface}  100    172.16.201.1/255.255.255.0
    network delete interface    ${SYSTEM_TEST_INTF_3}   181598
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}
