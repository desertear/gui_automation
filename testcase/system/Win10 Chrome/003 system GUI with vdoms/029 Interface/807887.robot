*** Settings ***
Documentation   Verify GUI changing interface to "DMZ" role will hide DHCP and following settings
Resource    ../../../system_resource.robot

*** Variables ***
${locater_DHCP SERVER}           ${NETWORK_INTERFACE_DHCP_SERVER_LABEL}
${locater_Admission Control}     ${NETWORK_INTERFACES_EDIT_ADMISSION_CONTROL}
${locater_Security Mode}    ${NETWORK_INTERFACES_EDIT_SECURITY_MODE}
@{list}      DHCP SERVER    Admission Control     Security Mode
*** Test Cases ***
807887
    [Documentation]    
    [Tags]    v6.0    chrome   807887    High    win10,64bit    runable
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ### check by default these items are shown in the page##
    :FOR  ${element}   IN    @{list}
         \  ${staus}=  run Keyword and return status   wait until element is visible   ${locater_${element}}
         \  should be equal   "${staus}"    "True"
    ### change the interface staus to DMZ, confirm that the items are disapperaed ####
    wait and click     ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   DMZ
    wait and click     ${new_locator}
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
