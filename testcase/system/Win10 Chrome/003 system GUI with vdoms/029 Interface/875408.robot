*** Settings ***
Documentation    Failcase! with bug #0521662
...              Verify LLDP Settings can be applied to aggregate , Redundant ,Software Switch and Vlan Switch(0497253)
Resource    ../../../system_resource.robot

*** Variables ***
${phy_interface}    ${SYSTEM_TEST_INTF_3}
@{phy_interface_list}    ${SYSTEM_TEST_INTF_3}
@{list}         enable    disable    vdom
@{type_list}    Agg    Redun   Soft
${test_interface_Agg}     875408_Agg
${test_interface_Redun}    875408_Redun
${test_interface_Soft}    875408_Soft

*** Test Cases ***
875408
    [Documentation]    
    [Tags]    Failcase!Bug#0521662   v6.0    chrome   875408   High    win10,64bit    runable    env2fail
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Create Network Interface  ${test_interface_Agg}    Agg     ${phy_interface_list}  100  
    :FOR   ${element}   IN    @{list}
        \  network edit interface  ${SYSTEM_TEST_INTF_3}   ${test_interface_Agg}  table_type=Agg
        \  ${new_label_rec}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_LABEL}     ${element}
        \  ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    ${element}
        \  ${new_label_tra}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_LABEL}   ${element}
        \  ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}  ${element}
        \  wait and click   ${new_label_rec}
        \  wait and click   ${new_label_tra}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
        \  network edit interface  ${phy_interface}   ${test_interface_Agg}    table_type=Agg
        \  sleep   2
        \  ${status_rec}=    get element attribute    ${new_select_rec}    checked
        \  ${status_tra}=    get element attribute    ${new_select_tra}    checked
        \  should be equal  "${status_rec}"    "true"
        \  should be equal  "${status_tra}"    "true"
        \  wait and click    ${SUBMIT_OK_BUTTON}
        \  unselect frame
    network delete interface ref   main_interface_name=${test_interface_Agg}   ref_table=Address   ref_name=${test_interface_Agg} address   table_type=Agg
    sleep   2
    network delete interface  ${phy_interface}   ${test_interface_Agg}   table_type=Agg

    Create Network Interface  ${test_interface_Redun}    Redun   ${phy_interface_list}  100  
    :FOR   ${element}   IN    @{list}
        \  network edit interface  ${SYSTEM_TEST_INTF_3}   ${test_interface_Redun}   table_type=Redun
        \  ${new_label_rec}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_LABEL}     ${element}
        \  ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    ${element}
        \  ${new_label_tra}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_LABEL}   ${element}
        \  ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}  ${element}
        \  wait and click   ${new_label_rec}
        \  wait and click   ${new_label_tra}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
        \  network edit interface  ${phy_interface}   ${test_interface_Redun}   table_type=Redun
        \  sleep   2
        \  ${status_rec}=    get element attribute    ${new_select_rec}    checked
        \  ${status_tra}=    get element attribute    ${new_select_tra}    checked
        \  should be equal  "${status_rec}"    "true"
        \  should be equal  "${status_tra}"    "true"
        \  wait and click    ${SUBMIT_OK_BUTTON}
        \  unselect frame
    network delete interface ref   main_interface_name=${test_interface_Redun}   ref_table=Address   ref_name=${test_interface_Redun} address   table_type=Redun
    sleep   2
    network delete interface  ${phy_interface}   ${test_interface_Redun}    table_type=Redun    table_type=Redun

    Create Network Interface  ${test_interface_Soft}  Soft   ${phy_interface_list}  100  
    :FOR   ${element}   IN    @{list}
        \  network edit interface  ${SYSTEM_TEST_INTF_3}  ${test_interface_Soft}    table_type=Soft
        \  ${new_label_rec}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_LABEL}     ${element}
        \  ${new_select_rec}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_SELECT}    ${element}
        \  ${new_label_tra}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_LABEL}   ${element}
        \  ${new_select_tra}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_SELECT}  ${element}
        \  wait and click   ${new_label_rec}
        \  wait and click   ${new_label_tra}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
        \  network edit interface  ${phy_interface}   ${test_interface_Soft}    table_type=Soft
        \  sleep   2
        \  ${status_rec}=    get element attribute    ${new_select_rec}    checked
        \  ${status_tra}=    get element attribute    ${new_select_tra}    checked
        \  should be equal  "${status_rec}"    "true"
        \  should be equal  "${status_tra}"    "true"
        \  wait and click    ${SUBMIT_OK_BUTTON}
        \  unselect frame
    network delete interface ref   main_interface_name=${test_interface_Soft}   ref_table=Address   ref_name=${test_interface_Soft} address   table_type=Soft
    sleep   2
    network delete interface  ${test_interface_Soft}   ${test_interface_Soft}    table_type=Soft 
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   

