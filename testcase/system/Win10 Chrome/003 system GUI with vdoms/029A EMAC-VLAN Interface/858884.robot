*** Settings ***
Documentation   Verify limitation that parent interfaces of EMAC-VLAN can't as member of virtual-wire-pair on CLI/GUI
Resource    ../../../system_resource.robot

*** Variables ***
${test_emac}    858884_emac
@{list_test_ph_intf}   ${SYSTEM_TEST_INTF_3}
${test_ph_intf}   ${SYSTEM_TEST_INTF_3}
${vlan_id_emac}   100
${vwp_name}    858884
*** Test Cases ***
858884
    [Documentation]    
    [Tags]    v6.0    chrome   858884    Low     win10,64bit    runable   novm
    login FortiGate
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    go to network_Interfaces
    Create Network Interface  ${test_emac}  type=EMAC  physical_interface=${list_test_ph_intf}  vlan_id=${vlan_id_emac} 
    ${status}=    run keyword and return status    Create Network Vwp Interface  ${vwp_name}  ${SYSTEM_TEST_INTF_4}  ${test_ph_intf}
    should be equal    "${status}"    "False"
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
