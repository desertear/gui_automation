*** Settings ***
Documentation   Verify emac-vlan can be created/edited/deleted with physical interface and vlan interface on GUI
Resource    ../../../system_resource.robot

*** Variables ***
${test_ph_emac}    850897_emac_ph
${test_vlan_emac}    850897_em_vlan
@{phy_test_ph_intf}    ${SYSTEM_TEST_INTF_3}
@{phy_test_vlan_log_intf}   850897_vlan
${test_ph_intf}    ${SYSTEM_TEST_INTF_3}
${test_vlan_log_intf}   850897_vlan
${vlan_id_vlan}    30
${vlan_id_emac}    100
${edit_role_to}    DMZ

*** Test Cases ***
850897
    [Documentation]    
    [Tags]    v6.0    chrome   850897    Critical     win10,64bit    runable   novm
    login FortiGate
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    go to network_Interfaces
    Create Network Interface  ${test_ph_emac}  type=EMAC  physical_interface=${phy_test_ph_intf}  vlan_id=${vlan_id_emac} 
    network select interface  main_interface_name=${test_ph_emac}    table_type=EMAC
    unselect frame
    Create Network Interface  ${test_vlan_log_intf}  type=VLAN  physical_interface=${phy_test_ph_intf}  vlan_id=${vlan_id_vlan} 
    unselect frame
    Create Network Interface  ${test_vlan_emac}   type=EMAC  physical_interface=${phy_test_vlan_log_intf}    vlan_id=${vlan_id_emac} 
    network select interface  main_interface_name=${test_vlan_emac}     table_type=EMAC
    sleep  2
    unselect frame
    network edit interface  main_interface_name=${test_ph_emac}    table_type=EMAC
    Set Interface Role To   ${edit_role_to}
    network edit interface  main_interface_name=${test_ph_emac}    table_type=EMAC
    wait until Element Is Visible    ${NETWORK_INTERFACES_EDIT_ROLE_SELECTED}
    ${role}=   get text   ${NETWORK_INTERFACES_EDIT_ROLE_SELECTED}
    should be equal    "${role}"    "${edit_role_to}"
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame
    network delete interface ref   main_interface_name=${test_vlan_emac}   ref_table=Address   ref_name=${test_vlan_emac} address   table_type=EMAC
    sleep   2
    network delete interface       main_interface_name=${test_vlan_emac}   table_type=EMAC
    sleep   2
    network delete interface ref   main_interface_name=${test_ph_emac}     ref_table=Address   ref_name=${test_ph_emac} address    table_type=EMAC
    sleep   2
    network delete interface       main_interface_name=${test_ph_intf}     subside_interface_name=${test_ph_emac}
    sleep   2
    network delete interface ref   main_interface_name=${test_ph_intf}     subside_interface_name=${test_vlan_log_intf}   ref_table=Address   ref_name=${test_vlan_log_intf} address
    sleep   2
    network delete interface       main_interface_name=${test_ph_intf}     subside_interface_name=${test_vlan_log_intf}
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
