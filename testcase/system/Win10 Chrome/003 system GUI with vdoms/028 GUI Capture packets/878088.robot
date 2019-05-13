*** Settings ***
Documentation   Verify user can start/stop the capture for physical interfaces
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}    ${FGT_VLAN20_INTERFACE}
*** Test Cases ***
878088
    [Documentation]    
    [Tags]    v6.0    chrome   878088    High    win10,64bit    runable
    login FortiGate    browser=chrome
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_packet_capture
    Set Capture interface    ${capture_interface}
    ### begin to capture packets####
    select frame   ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click    ${new_locator}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}   ${capture_interface}
    wait and click    ${new_locator}
    sleep  5
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_STOP_BUTTON}   ${capture_interface}
    wait and click    ${new_locator}
    Sleep  2
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_DOWNLOAD_BUTTON}   ${capture_interface}
    wait and click    ${new_locator}
    sleep   10
    ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    sleep   5
    Remove File       ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    wait and click    ${NETWORK_PACKET_DELETE_BUTTON} 
    unselect frame
    wait and click    ${NETWORK_PACKET_DELETE_OK_BUTTON}     
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
