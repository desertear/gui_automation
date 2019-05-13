*** Settings ***
Documentation    Verify capture works on hardware switch, members of software switch, or virtual wire pair, or wan links
Resource    ../../../system_resource.robot

*** Variables ***
@{interface_soft_interface}     ${SYSTEM_TEST_INTF_1}
${capture_interface_vwp_name}    739191
${capture_interface_soft_name}    739191
${capture_interface_soft_interface}     ${SYSTEM_TEST_INTF_1}
${capture_interface_vwp_interface_1}    ${SYSTEM_TEST_INTF_3}
${capture_interface_vwp_interface_2}    ${SYSTEM_TEST_INTF_4}
@{list_interface}           ${capture_interface_vwp_interface_1}   ${SYSTEM_TEST_INTF_2}   ${capture_interface_vwp_interface_2}    ${capture_interface_soft_name}
*** Test Cases ***
739191
    [Documentation]    
    [Tags]    v6.0    chrome   739191    High    win10,64bit    runable    env2fail
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    browser=chrome
    Go to network
    Go to network_Interfaces
    sleep    2
    ${int_locator}=    network select interface     ${capture_interface_soft_interface}
    ${ref_locator}=    CATENATE  SEPARATOR=    ${int_locator}    ${NETWORK_INTERFACES_TABLE_REF}
    wait and click   ${ref_locator}
    Capture Page Screenshot 
    unselect frame
    wait and click    ${NETWORK_INTERFACES_REF_ITEM_CLOSE_BUTTON}
    sleep  1
    unselect frame
    ${int_locator}=    network select interface     ${capture_interface_vwp_interface_1}        
    ${ref_locator}=    CATENATE  SEPARATOR=    ${int_locator}    ${NETWORK_INTERFACES_TABLE_REF}
    wait and click   ${ref_locator}
    Capture Page Screenshot 
    unselect frame
    wait and click    ${NETWORK_INTERFACES_REF_ITEM_CLOSE_BUTTON}
    sleep  1
    unselect frame
    sleep    2
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    ###  create software switch and vwp ####
    Create Network Interface   ${capture_interface_soft_name}    Software   ${interface_soft_interface}
    sleep   2
    select frame        ${NETWORK_FRAME}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_VIRTUAL}
    wait until element is visible       ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME}
    clear element text  ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME_INPUT}
    input text          ${NETWORK_INTERFACES_CREATE NEW_VWP_NAME_INPUT}    ${capture_interface_vwp_name}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_VWP_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE  ${capture_interface_vwp_interface_1}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_VWP_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE  ${capture_interface_vwp_interface_2}
    wait and click      ${SUBMIT_OK_BUTTON}
    ### set an interface to WAN mode ###
    network edit interface     ${SYSTEM_TEST_INTF_2}
    wait and click    ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   WAN
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    ###  capture the interfaces above ###
    Go to network
    Go to network_Interfaces
    Go to network_packet_capture  
    Set Capture interface    ${capture_interface_vwp_interface_1} 
    Set Capture interface    ${SYSTEM_TEST_INTF_2}   6000   filter  ipv6  non_ip  host=10.1.100.1  port=80  vlan=100  protocol=6 
    Set Capture interface    ${capture_interface_vwp_interface_2}
    Set Capture interface    ${capture_interface_soft_name}
    ### start to capture packets and check the cap file is downloaded ####
    ${i}=    set Variable    1
    :FOR  ${element}   IN    @{list_interface}
        \  select frame      ${NETWORK_FRAME}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}            ${element}
        \  wait and click    ${new_locator}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}     ${element}
        \  wait and click    ${new_locator}
        \  sleep  5
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_STOP_BUTTON}      ${element}
        \  wait and click    ${new_locator}
        \  Sleep  2
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_DOWNLOAD_BUTTON}  ${element}
        \  ${status}=    run keyword and return status    wait until element is visible  ${new_locator}
        \  run keyword if   "${status}"=="True"     wait and click     ${new_locator}
        \  run keyword if   "${status}"=="True"     sleep   10
        \  run keyword if   "${status}"=="True"     ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${element}.${SYSTEM_TEST_VDOM_NAME_1}.${i}.pcap
        \  run keyword if   "${status}"=="True"     sleep   5
        \  run keyword if   "${status}"=="True"     Remove File      ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${element}.${SYSTEM_TEST_VDOM_NAME_1}.${i}.pcap
        \  ${i}=  Evaluate   ${i}+1 
        \  unselect frame
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

   

