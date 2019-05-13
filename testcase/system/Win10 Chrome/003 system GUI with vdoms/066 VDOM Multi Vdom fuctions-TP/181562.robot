*** Settings ***
Documentation    To verify in TP mode, VLAN interface VLAN ID could not be modified if it is in a policy in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_vlan_int_name}   ${SYSTEM_TEST_INTF_3}
${vlan_int_name}   181562
${policy_name}   181562
*** Test Cases ***
181562
    [Tags]    v6.0    chrome   181562   Medium     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}   
    Go to network
    Go to network_Interfaces
    Create Network Interface    ${vlan_int_name}   VLAN   ${phy_vlan_int_name}  100   vdom_mode_tp=yes 
    Go to network
    go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy   ${policy_name}   ${vlan_int_name}    ${SYSTEM_TEST_INTF_3}
    Go to policy and objects
    Go to network
    Go to network_Interfaces
    network edit interface      ${SYSTEM_TEST_INTF_3}   ${vlan_int_name}    VLAN
    ${status}=    run keyword and return status    wait until Element Is Visible   ${network_interfaces_create or edit_VLAN ID}
    should be equal    "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

