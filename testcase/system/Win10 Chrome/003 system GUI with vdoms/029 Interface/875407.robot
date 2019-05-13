*** Settings ***
Documentation    Failcase! with bug #0521662
...              Verify LLDP settings can be applied to the VLAN Interface
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_interface}    ${SYSTEM_TEST_INTF_3}
@{list}         enable    disable    vdom
*** Test Cases ***
875407
    [Documentation]    
    [Tags]    Failcase!Bug#0521662   v6.0    chrome   875407   High    win10,64bit    runable    env2fail
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Create Network Interface  875407  VLAN  ${phy_interface}  100  
    :FOR   ${element}   IN    @{list}
        \  network edit interface  ${SYSTEM_TEST_INTF_3}   875407  
        \  ${new_label_rec}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_LABEL}     ${element}
        \  ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    ${element}
        \  ${new_label_tra}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_LABEL}   ${element}
        \  ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}  ${element}
        \  wait and click   ${new_label_rec}
        \  wait and click   ${new_label_tra}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
        \  network edit interface  ${SYSTEM_TEST_INTF_3}   875407  
        \  sleep   2
        \  ${status_rec}=    get element attribute    ${new_select_rec}    checked
        \  ${status_tra}=    get element attribute    ${new_select_tra}    checked
        \  should be equal  "${status_rec}"    "true"
        \  should be equal  "${status_tra}"    "true"
        \  wait and click    ${SUBMIT_OK_BUTTON}
        \  unselect frame
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   

