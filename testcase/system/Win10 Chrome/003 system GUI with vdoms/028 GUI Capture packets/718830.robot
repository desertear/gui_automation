*** Settings ***
Documentation    Verify cannot delete interface which is used by packet capture
Resource    ../../../system_resource.robot

*** Variables ***
@{interface_vlan_phy_int}   ${SYSTEM_TEST_INTF_2}
${capture_interface_vlan_name}    718830_vlan
${capture_interface_vlan_phy_int}   ${SYSTEM_TEST_INTF_2}
${capture_interface_vlan_ip}    172.16.201.1/255.255.255.0
*** Test Cases ***
718830
    [Documentation]    
    [Tags]    v6.0    chrome   718830    Medium    win10,64bit    runable
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    go to network_Interfaces
    Create Network Interface   ${capture_interface_vlan_name}    VLAN      ${interface_vlan_phy_int}   ipmask=${capture_interface_vlan_ip}
    Go to network_packet_capture
    Set Capture interface      ${capture_interface_vlan_name}
    ### Try to deleted interface which is captured, should not be deleted ####
    Go to network
    Go to network_Interfaces
    ${status}=   run keyword and return status    network delete interface     ${capture_interface_vlan_phy_int}      ${capture_interface_vlan_name}
    should be equal    "${status}"    "False"
######  deleted the capture entry #####
    unselect frame
    Go to network
    Go to network_packet_capture
    select frame      ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface_vlan_name}
    wait and click    ${new_locator}
    wait and click    ${NETWORK_PACKET_DELETE_BUTTON} 
    unselect frame
    wait and click    ${NETWORK_PACKET_DELETE_OK_BUTTON}     
    ### Try to deleted interface after capture is removed, interface should be deleted ####
    Go to network
    Go to network_Interfaces
    ${status}=   run keyword and return status    network delete interface     ${capture_interface_vlan_phy_int}      ${capture_interface_vlan_name}
    sleep   2
    should be equal    "${status}"    "True"
    Go to network_packet_capture
    Go to network_packet_capture
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

    
 