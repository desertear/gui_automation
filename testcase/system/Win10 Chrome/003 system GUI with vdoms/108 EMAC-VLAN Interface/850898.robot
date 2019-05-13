*** Settings ***
Documentation   Verify emac-vlan can be created/edited/deleted with physical interface and vlan interface on GUI
Resource    ../../../system_resource.robot

*** Variables ***
@{list_test_ph_intf_1}    ${SYSTEM_TEST_INTF_3}
@{list_test_ph_intf_2}    ${SYSTEM_TEST_INTF_4}
@{list_test_agg_intf}   850898_agg
@{list_test_redun_intf}   850898_redun
${test_agg_emac}      850898_em_agg
${test_redun_emac}    850898_em_redun
${test_ph_intf_1}    ${SYSTEM_TEST_INTF_3}
${test_ph_intf_2}    ${SYSTEM_TEST_INTF_4}
${test_redun_intf}   850898_redun
${test_agg_intf}   850898_agg
${test_zone}   850898_zone
${vlan_id_vlan}    30
${vlan_id_emac}    100
${edit_role_to}    DMZ

*** Test Cases ***
850898
    [Documentation]    
    [Tags]    v6.0    chrome   850898    High     win10,64bit    runable   novm    env2fail
    login FortiGate
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    go to network_Interfaces
    Create Network Interface  ${test_agg_intf}    type=Agg    physical_interface=${list_test_ph_intf_1}
    sleep   2
    Create Network Interface  ${test_redun_intf}  type=Redu   physical_interface=${list_test_ph_intf_2}
    sleep   2
    Create Network Interface  ${test_agg_emac}    type=EMAC   physical_interface=${list_test_agg_intf}
    sleep   2
    Create Network Interface  ${test_redun_emac}  type=EMAC   physical_interface=${list_test_redun_intf} 
    sleep   2
    network select interface  ${test_redun_emac}     table_type=EMAC
    unselect frame
    network select interface  ${test_agg_emac}     table_type=EMAC
    unselect frame
    network edit interface  ${test_agg_emac}    table_type=EMAC
    Set Interface Role To   ${edit_role_to}
    network edit interface  ${test_agg_emac}    table_type=EMAC
    wait until Element Is Visible    ${NETWORK_INTERFACES_EDIT_ROLE_SELECTED}
    ${role}=   get text   ${NETWORK_INTERFACES_EDIT_ROLE_SELECTED}
    should be equal    "${role}"    "${edit_role_to}"
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame
    create zone    ${test_zone}    ${test_agg_emac} 
    network select interface  main_interface_name=${test_zone}   subside_interface_name=${test_agg_emac}   table_type=Zone
    unselect frame
    delete zone interface   ${test_zone}    ${test_agg_emac}
    unselect frame
    network delete interface   ${test_zone}    table_type=Zone
    sleep   2
    network delete interface   main_interface_name=${test_redun_intf}   subside_interface_name=${test_redun_emac}   table_type=Redun
    sleep   2
    network delete interface   main_interface_name=${test_agg_intf}     subside_interface_name=${test_agg_emac}     table_type=Agg
    sleep   2
    network delete interface ref   ${test_redun_intf}   ref_table=Address   ref_name=${test_redun_intf} address    table_type=Redun
    sleep   2
    network delete interface   ${test_redun_intf}   table_type=Redun
    sleep   2
    network delete interface ref   ${test_agg_intf}   ref_table=Address   ref_name=${test_agg_intf} address    table_type=Agg
    sleep   2
    network delete interface   ${test_agg_intf}   table_type=Agg
    sleep   2   
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
