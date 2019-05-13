*** Settings ***
Documentation    Verify Tags can be added mandatory or optionally and enable/disable allow multiple tag selection works
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}    ${FGT_VLAN20_INTERFACE}

*** Test Cases ***
718825
    [Documentation]    
    [Tags]    v6.0    chrome   718825    Critical    win10,64bit    runable
    login FortiGate    browser=chrome
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_packet_capture
    Set Capture interface    ${capture_interface}
    Edit Capture     ${capture_interface}
    ${status}=       run keyword and return status   checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_CHECKBOX}
    run keyword if   "${status}"=="False"   wait and click       ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_LABEL}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Host
    wait and click   ${new_locator}
    input text       ${new_locator}   ${FGT_VLAN20_IP}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Port
    wait and click   ${new_locator}
    input text       ${new_locator}   1443
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   VLAN
    wait and click   ${new_locator}
    input text       ${new_locator}   20
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Protocol
    wait and click   ${new_locator}
    input text       ${new_locator}   1,6
    ${status}=       run keyword and return status     checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_CHECKBOX}
    run keyword if  "${status}"=="False"               wait and click                ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_LABEL}
    ${status}=       run keyword and return status     checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_CHECKBOX}
    run keyword if  "${status}"=="False"               wait and click                ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_LABEL}
    wait and click   ${SUBMIT_OK_BUTTON}
    ### begin to capture packets####
    select frame     ${NETWORK_FRAME}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}           ${capture_interface}
    wait and click   ${new_locator}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}    ${capture_interface}
    wait and click   ${new_locator}
    sleep  5
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_STOP_BUTTON}     ${capture_interface}
    wait and click   ${new_locator}
    Sleep  2
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_DOWNLOAD_BUTTON}  ${capture_interface}
    wait and click   ${new_locator}
    sleep   10
    should exist     ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    sleep   5
    Remove File      ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    wait and click   ${NETWORK_PACKET_DELETE_BUTTON} 
    unselect frame
    wait and click   ${NETWORK_PACKET_DELETE_OK_BUTTON}     
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
