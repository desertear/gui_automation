*** Settings ***
Documentation      Verify NPU_vdom_link and it's vlan show correctly on GUI at Global/Vdom level when vdom is enabled
Resource    ../../../system_resource.robot

*** Variables ***
@{npu_intf}    npu0_vlink0
${vlan_int_name}    732425
*** Test Cases ***
732425
    [Tags]    v6.0    chrome   732425    High    win10,64bit    browsers    runable   novm
    Login FortiGate
    sleep  2
    Go to network
    Go to network_Interfaces
    Create Network Interface    ${vlan_int_name}   VLAN   ${npu_intf}    100 
    unselect frame
    Go to network
    Go to network_Interfaces
    network select interface    npu0_vlink   ${vlan_int_name}  VDOM
    unselect frame
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    sleep  2
    Go to network
    Go to network_Interfaces
    network select interface    npu0_vlink   ${vlan_int_name}  VDOM
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Close All Browsers
    Run Cli commands in File     ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
