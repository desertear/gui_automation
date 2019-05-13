*** Settings ***
Documentation   Verify GUI changing interface to "WAN" role will change to DHCP mode by default and hide following features
Resource    ../../../system_resource.robot

*** Variables ***
${locater_One-Arm Sniffer}    ${NETWORK_INTERFACE_ADDRESSING MODE_ONE_ARM_SNIFFER}
${locater_Dedicated to FortiSwitch}    ${NETWORK_INTERFACE_ADDRESSING MODE_Dedicated to FortiSwitch}
${locater_DHCP SERVER}                              ${NETWORK_INTERFACE_DHCP_SERVER_LABEL}
${locater_Admission Control}     ${NETWORK_INTERFACES_EDIT_ADMISSION_CONTROL}
${locater_Security Mode}    ${NETWORK_INTERFACES_EDIT_SECURITY_MODE}
@{list}    One-Arm Sniffer    DHCP SERVER    Admission Control     Security Mode
*** Test Cases ***
807885
    [Documentation]    
    [Tags]    v6.0    chrome   807885    High    win10,64bit    runable
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click    ${new_locator}
    ### check by default these items are shown in the page##
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "True"
    ### change the interface staus to WAN, confirm that the items are disapperaed ####
    wait and click    ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   WAN
    wait and click    ${new_locator}
    ### here is a bug with id 0442019, when change to wan, default is static,not dhcp  ####
    #radio button should be set to   mode   dhcp
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "False"
    unselect frame
    sleep   2
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
