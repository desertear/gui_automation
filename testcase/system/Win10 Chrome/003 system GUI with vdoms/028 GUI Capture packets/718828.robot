*** Settings ***
Documentation    Verify user can start capture and download pcap file at "edit packet capture" window
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}           ${FGT_VLAN20_INTERFACE}
${capture_filter_ip}           ${FGT_VLAN20_IP}

*** Test Cases ***
718828
    [Documentation]    
    [Tags]    v6.0    chrome   718828    Critical    win10,64bit    runable
    login FortiGate    browser=chrome
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_packet_capture
    Set Capture interface  ${capture_interface}
    Edit Capture           ${capture_interface}
    ${status}=   run keyword and return status     checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_CHECKBOX}
    run keyword if    "${status}"=="False"   wait and click       ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_LABEL}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Host
    wait and click    ${new_locator}
    input text        ${new_locator}   ${capture_filter_ip}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Port
    wait and click    ${new_locator}
    input text        ${new_locator}   1443
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   VLAN
    wait and click    ${new_locator}
    input text        ${new_locator}   20
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_FILTER_ITEM}   Protocol
    wait and click    ${new_locator}
    input text        ${new_locator}    1,6
    ${status}=   run keyword and return status     checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_CHECKBOX}
    run keyword if    "${status}"=="False"   wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_IPV6_LABEL}
    ${status}=   run keyword and return status     checkbox should be selected   ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_CHECKBOX}
    run keyword if    "${status}"=="False"   wait and click    ${NETWORK_PACKET_CAPTURE_CREATE_NEW_NON_IP_LABEL}
    wait and click  ${SUBMIT_OK_BUTTON}
    ### begin to capture packets####
    Edit Capture    ${capture_interface}
    wait and click  ${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_PLAY_BUTTON}
    sleep   10
    wait and click  ${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_STOP_BUTTON}
    sleep   2
    wait and click  ${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_DOWNLOAD_BUTTON}
    sleep   10
    ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    sleep   5
    Remove File      ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    wait and click   ${SUBMIT_OK_BUTTON}
    select frame     ${NETWORK_FRAME}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click   ${new_locator}
    wait and click   ${NETWORK_PACKET_DELETE_BUTTON} 
    unselect frame
    wait and click   ${NETWORK_PACKET_DELETE_OK_BUTTON}     
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
