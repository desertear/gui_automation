*** Settings ***
Documentation    Verify changing the mode of interface the LLDP settings change
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
875409
    [Documentation]    
    [Tags]    v6.0    chrome   875409   High    win10,64bit    runable    
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    Set Interface Role To   LAN
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}   enable
    ${status_tra}=       get element attribute    ${new_select_tra}   checked
    should be equal     "${status_tra}"    "true"
    
    Set Interface Role To   WAN
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}   enable
    ${status_rec}=       get element attribute    ${new_select_rec}   checked
    should be equal     "${status_rec}"    "true"
    
    Set Interface Role To   DMZ
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    vdom
    ${status_rec}=       get element attribute    ${new_select_rec}   checked
    should be equal     "${status_rec}"    "true"
    ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}   vdom
    ${status_tra}=       get element attribute    ${new_select_tra}   checked
    should be equal     "${status_tra}"    "true"
   
    Set Interface Role To   Undefined
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    vdom
    ${status_rec}=       get element attribute    ${new_select_rec}   checked
    should be equal     "${status_rec}"    "true"
    ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}   vdom
    ${status_tra}=       get element attribute    ${new_select_tra}   checked
    should be equal     "${status_tra}"    "true"
   
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   

