*** Settings ***
Documentation   Verify GUI changing interface to "WAN" role will change to DHCP mode by default and hide following features
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
807922
    [Documentation]    
    [Tags]    v6.0    chrome   807922    High    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ### check by default these items are shown in the page##
    ${status}=     run keyword and return status   wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    should be equal    "${status}"     "False"
    sleep   2
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
