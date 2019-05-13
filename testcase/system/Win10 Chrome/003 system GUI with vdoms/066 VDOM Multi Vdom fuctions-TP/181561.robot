*** Settings ***
Documentation    To verify in TP mode, VLAN interface could be created and deleted in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_vlan_int_name}   ${SYSTEM_TEST_INTF_3}
${vlan_int_name}   181561
*** Test Cases ***
181561
    [Tags]    v6.0    chrome   181561   Critical     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}   
    Go to network
    Go to network_Interfaces
    Create Network Interface    ${vlan_int_name}   VLAN  ${phy_vlan_int_name}  100   vdom_mode_tp=yes 
    network delete interface    ${SYSTEM_TEST_INTF_3}    ${vlan_int_name}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

