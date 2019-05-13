*** Settings ***
Documentation   Verify GUI can set interface's "Role" and each "Role" show/hide certain features on interface page based on the role selection
Resource    ../../../system_resource.robot

*** Variables ***
${locater_One-Arm Sniffer}    ${NETWORK_INTERFACE_ADDRESSING MODE_ONE_ARM_SNIFFER}
${locater_Dedicated to FortiSwitch}    ${NETWORK_INTERFACE_ADDRESSING MODE_Dedicated to FortiSwitch}
${locater_DHCP SERVER}           ${NETWORK_INTERFACE_DHCP_SERVER_LABEL}
${locater_Admission Control}     ${NETWORK_INTERFACES_EDIT_ADMISSION_CONTROL}
${locater_Security Mode}    ${NETWORK_INTERFACES_EDIT_SECURITY_MODE}
${address_object_matching_label}    xpath://span[span="Create address object matching subnet"]/label
@{list_DMZ}      DHCP SERVER    Admission Control     Security Mode
@{list}      One-Arm Sniffer    DHCP SERVER    Admission Control     Security Mode
*** Test Cases ***
807899
    [Documentation]    
    [Tags]    v6.0    chrome   807899    High    win10,64bit    runable
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ### check by default these items are shown in the page##
    wait and click     ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "True"

    ### change the interface staus to WAN, confirm that the items are disapperaed ####
    wait and click     ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   WAN
    wait and click     ${new_locator}
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "False"

    ### change the interface staus to DMZ, confirm that the items are disapperaed ####
    wait and click     ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   DMZ
    wait and click     ${new_locator}
    :FOR  ${element}   IN    @{list_DMZ}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "False"
    
    ### change the interface staus to DMZ, confirm that the items are disapperaed ####
    wait and click     ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   Undefined
    wait and click     ${new_locator}
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "True"
    ${staus}=    run Keyword and return status   wait until element is visible   ${address_object_matching_label}
    should be equal   "${staus}"    "False"
    sleep   2
    unselect frame
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
