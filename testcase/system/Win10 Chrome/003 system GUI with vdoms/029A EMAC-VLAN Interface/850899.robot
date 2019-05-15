*** Settings ***
Documentation   Verify emac-vlan interface can be added to Bandwidth widget and displayed correctly on GUI
Resource    ../../../system_resource.robot

*** Variables ***
${test_emac}    850899_emac
@{test_ph_intf}    ${SYSTEM_TEST_INTF_3}
${vlan_id_emac}   100
*** Test Cases ***
850899
    [Documentation]    
    [Tags]    v6.0    chrome   850899    High     win10,64bit    runable   novm   
    login FortiGate
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    go to network_Interfaces
    Create Network Interface  ${test_emac}  type=EMAC  physical_interface=${test_ph_intf}  vlan_id=${vlan_id_emac} 
    network select interface  main_interface_name=${test_emac}    table_type=EMAC
    unselect frame
    sleep  2
    go to dashboard
    Go to dashboard_main
    system_Add_widget_bandwith     ${test_emac}
    check if the Bandwidth of interface widget is appeared in the main page    ${test_emac}
    sleep   2
    system_reset_dashboard
    sleep   5
    Go to dashboard_main
    go to dashboard
    Go to network
    go to network_Interfaces
    network delete interface ref   main_interface_name=${test_emac}   ref_table=Address   ref_name=${test_emac} address   table_type=EMAC
    sleep   2
    network delete interface       main_interface_name=${test_emac}   table_type=EMAC
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
