*** Settings ***
Documentation    Verify no packet capture can set to "All" interfaces
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface_vlan_name}   All
*** Test Cases ***
718831
    [Documentation]    
    [Tags]    v6.0    chrome   718831    low    win10,64bit    runable
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_packet_capture
    ${status}=   run key word and return status    Set Capture interface    ${capture_interface_vlan_name}
    should be equal   "${status}"    "False"
    wait and click     ${dropdown_mask}
    wait and click     ${SUBMIT_CANCEL_BUTTON}
    unselect frame
    Go to network_packet_capture
    Go to network_packet_capture
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

    
 