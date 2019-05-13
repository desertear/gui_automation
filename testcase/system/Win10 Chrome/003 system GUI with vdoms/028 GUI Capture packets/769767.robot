*** Settings ***
Documentation    Verify packet-capture read-only admin can sniffer but cannot create new capture
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}   ${SYSTEM_TEST_INTF_1}
@{list_interface}      ${SYSTEM_TEST_INTF_2}     ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
769767
    [Documentation]    
    [Tags]    v6.0    chrome   769767    Medium    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    
    Go To Vdom        ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    Go to network_packet_capture
    Set Capture interface  ${capture_interface}
    select frame      ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click    ${new_locator}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}   ${capture_interface}
    wait and click    ${new_locator}
    unselect frame
    Logout FortiGate  
    login FortiGate    username=769767    password=123    browser=chrome
    Go to network
    Go to network_packet_capture
    select frame      ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    ${status}=        run keyword and return status     wait and click    ${new_locator}
    should be equal  "${status}"   "True"
    unselect frame
    :FOR    ${element}  IN    @{list_interface}
         \  ${status}=        run keyword and return status     Set Capture interface  ${element}
         \  should be equal  "${status}"   "False"
         \  unselect frame
    Select Frame      ${NETWORK_FRAME}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click    ${new_locator}
    wait and click    ${NETWORK_PACKET_VIEW_BUTTON}  
    wait and click    ${NETWORK_PACKET_CAPTURE_EDIT_SNIFFER_DOWNLOAD_BUTTON}
    sleep   10
    Should Exist     ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    sleep   5
    Remove File      ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${capture_interface}.${SYSTEM_TEST_VDOM_NAME_1}.1.pcap
    unselect frame
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate    username=769767
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
